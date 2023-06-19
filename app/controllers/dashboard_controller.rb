# frozen_string_literal: true

class DashboardController < ApplicationController
  layout -> { ApplicationLayout }

  def index
    @films = Film.all.take(10)
    render Dashboard::IndexView.new(@films)
  end
end
