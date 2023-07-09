# frozen_string_literal: true

require Rails.root.join('app/views/components/dashboard_sidebar')
require Rails.root.join('app/views/components/dashboard_sidebar_item')
require Rails.root.join('app/views/components/dashboard_grid')
require Rails.root.join('app/views/components/films/item')
require Rails.root.join('app/views/components/actors/item')

class Dashboard::IndexView < ApplicationView
  def initialize(collection:, models:)
    @collection = collection
    @models = models
  end

  def template
    render Views::Components::DashboardSidebar.new(@models)
    render Views::Components::DashboardGrid.new(@collection)
  end
end
