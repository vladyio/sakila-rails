# frozen_string_literal: true

require File.join(Rails.root, 'app/views/components/films/item')

class Dashboard::IndexView < ApplicationView
  def initialize(films)
    @films = films
  end

  def template
    @films.each { |film| render Components::Film.new(film) }
  end
end
