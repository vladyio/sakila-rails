# frozen_string_literal: true

require File.join(Rails.root, 'app/views/components/dashboard/sidebar')
require File.join(Rails.root, 'app/views/components/films/item')

class Dashboard::IndexView < ApplicationView
  def initialize(**collections)
    @films = collections[:films]
    @models = collections[:models]
  end

  def template
    render Views::Components::Dashboard::Sidebar.new(@models)

    div(class: 'h-full ml-[235px] grid md:grid-cols-3 gap-1') do
      @films.each { |film| render Views::Components::Film.new(film) }
    end
  end
end
