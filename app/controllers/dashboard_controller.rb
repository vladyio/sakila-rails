# frozen_string_literal: true

class DashboardController < ApplicationController
  DASHBOARD_MODELS = %w[
    Store Staff Rental Payment Language Inventory Film
    Customer Country City Category Address Actor
  ].freeze

  FALLBACK_MODEL = Film

  # rubocop:disable Metrics/MethodLength
  def index
    @collection = collection_model.all.sample(20)
    @dashboard_models = DASHBOARD_MODELS.sort

    respond_to do |format|
      format.html do
        render Dashboard::IndexView.new(collection: @collection, models: @dashboard_models)
      end

      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          'items', Dashboard::Grid.new(@collection)
        )
      end
    end
  end

  private

  def dashboard_params
    params.permit(:model)
  end

  def collection_model
    model = dashboard_params[:model]

    return FALLBACK_MODEL unless DASHBOARD_MODELS.include?(model)

    model.constantize
  end
end
