# frozen_string_literal: true

class Dashboard::IndexView < ApplicationView
  def initialize(collection:, models:)
    @collection = collection
    @models = models
  end

  def template
    render Dashboard::Sidebar.new(@models)
    render Dashboard::Grid.new(@collection)
  end
end
