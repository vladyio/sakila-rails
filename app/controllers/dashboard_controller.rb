# frozen_string_literal: true

class DashboardController < ApplicationController
  layout -> { ApplicationLayout }
  
  def index
    render Dashboard::IndexView.new
  end
end
