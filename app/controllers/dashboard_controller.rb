# frozen_string_literal: true

class DashboardController < ApplicationController
  DASHBOARD_MODELS = %w[
    Store Staff Rental Payment Language Inventory Film
    Customer Country City Category Address Actor].freeze

  layout -> { ApplicationLayout }

  def index
    @films = Film.all.sample(10)
    @dashboard_models = DASHBOARD_MODELS.sort
    render Dashboard::IndexView.new(films: @films, models: @dashboard_models)
  end
end
