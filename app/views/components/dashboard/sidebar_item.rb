# frozen_string_literal: true

module Views
  module Components
    class Dashboard::SidebarItem < ApplicationComponent
      def initialize(model)
        @model = model
      end

      def template(&)
        li(class: 'relative') do
          a(class: 'navbar--item', href: helpers.root_path(model: @model),
            data: { turbo_stream: true }) { @model }
        end
      end
    end
  end
end
