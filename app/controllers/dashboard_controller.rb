# frozen_string_literal: true

class DashboardController < ApplicationController
  include Pagy::Backend

  DASHBOARD_MODELS = %w[
    Store Staff Rental Payment Language Inventory Film
    Customer Country City Category Address Actor
  ].freeze

  FALLBACK_MODEL = Film
  ITEMS_PER_PAGE = 21

  # rubocop:disable Metrics/MethodLength
  def index
    @pagy, @collection = pagy_countless(collection_model.all.load_async, items: ITEMS_PER_PAGE)
    @dashboard_models = DASHBOARD_MODELS.sort

    respond_to do |format|
      format.html do
        render Dashboard::IndexView.new(collection: @collection, models: @dashboard_models,
                                        pagy: @pagy)
      end

      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          'items', Dashboard::Grid.new(@collection, @pagy)
        )
      end
    end
  end

  private

  def dashboard_params
    params.permit(:model, :page)
  end

  def collection_model
    model = dashboard_params[:model]

    return FALLBACK_MODEL unless DASHBOARD_MODELS.include?(model)

    model.constantize
  end
end
