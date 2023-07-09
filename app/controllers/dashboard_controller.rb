# frozen_string_literal: true

class DashboardController < ApplicationController
  DASHBOARD_MODELS = %w[
    Store Staff Rental Payment Language Inventory Film
    Customer Country City Category Address Actor
  ].freeze

  FALLBACK_MODEL = 'Film'

  layout -> { ApplicationLayout }

  def index
    @collection = collection_model.all.sample(10)
    @dashboard_models = DASHBOARD_MODELS.sort

    render Dashboard::IndexView.new(collection: @collection, models: @dashboard_models)
  end

  private

  def dashboard_params
    params.permit(:model)
  end

  def collection_model
    model = dashboard_params[:model] || FALLBACK_MODEL
    model.constantize
  end
end
