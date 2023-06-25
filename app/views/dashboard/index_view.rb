# frozen_string_literal: true

require File.join(Rails.root, 'app/views/components/dashboard/sidebar')
require File.join(Rails.root, 'app/views/components/films/item')

class Dashboard::IndexView < ApplicationView
  def initialize(collection:, models:)
    @collection = collection
    @models = models
  end

  def template
    render Views::Components::Dashboard::Sidebar.new(@models)

    div(class: 'h-full ml-[235px] grid md:grid-cols-3 gap-1') do
      @collection.each { |item| render dashboard_component(item.class, item) }
    end
  end

  def dashboard_component(model, item)
    "Views::Components::#{model}".constantize.new(item)
  end
end
