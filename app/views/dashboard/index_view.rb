# frozen_string_literal: true

class Dashboard::IndexView < ApplicationView
  def template
    h1 { "Dashboard index" }
    p { "Find me in app/views/dashboard/index_view.rb" }
  end
end
