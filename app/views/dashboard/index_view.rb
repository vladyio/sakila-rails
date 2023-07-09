# frozen_string_literal: true

require Rails.root.join('app/views/components/films/item')
require Rails.root.join('app/views/components/actors/item')

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
