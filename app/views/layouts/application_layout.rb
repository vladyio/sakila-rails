# frozen_string_literal: true

class ApplicationLayout < ApplicationView
  include Phlex::Rails::Layout

  def template(&block)
    doctype

    html(class: 'h-full m-0 p-0 bg-indigo-700') do
      head do
        title { 'SakilaRails' }
        meta name: 'viewport', content: 'width=device-width,initial-scale=1'
        csp_meta_tag
        csrf_meta_tags
        stylesheet_link_tag 'application', data_turbo_track: 'reload'
        javascript_include_tag 'application', data_turbo_track: 'reload', defer: true
        stylesheet_link_tag 'tailwind', 'inter-font', 'data_turbo_track': 'reload'
      end

      body do
        main(class: 'h-full w-full bg-blue-900 grid md:grid-cols-3 gap-1', &block)
      end
    end
  end
end
