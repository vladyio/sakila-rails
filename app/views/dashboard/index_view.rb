# frozen_string_literal: true

class Dashboard::IndexView < ApplicationView
  def initialize(collection:, models:, pagy:)
    @collection = collection
    @models = models
    @pagy = pagy
  end

  def template
    render Dashboard::Sidebar.new(@models)
    render Dashboard::Grid.new(@collection, @pagy)
  end
end
