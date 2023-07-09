# frozen_string_literal: true

require Rails.root.join('app/views/components/dashboard_sidebar')
require Rails.root.join('app/views/components/dashboard_sidebar_item')
require Rails.root.join('app/views/components/films/item')
require Rails.root.join('app/views/components/actors/item')

class Dashboard::IndexView < ApplicationView
  def initialize(collection:, models:)
    @collection = collection
    @models = models
  end

  def template
    render Views::Components::DashboardSidebar.new(@models)

    div(class: 'h-full ml-[235px] grid md:grid-cols-3 gap-1') do
      @collection.each { |item| render dashboard_component(item.class, item) }
    end
  end

  def dashboard_component(model, item)
    "Views::Components::#{model}".constantize.new(item)
  end
end
