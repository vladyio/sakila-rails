# frozen_string_literal: true

module Views
  module Components
    class Dashboard::SidebarItem < ApplicationComponent
      def initialize(model)
        @model = model
      end

      def template(&)
        li(class: 'relative mb-1') do
          a(class: 'navbar--item', href: helpers.root_path(model: @model),
            data: { turbo_stream: true }) do
            span { @model.pluralize }

            span(class: 'rounded-full bg-gray-700 ml-[0.3em] px-[0.65em]
                          text-[0.75em] font-bold text-indigo-300') do
              @model.constantize.count
            end
          end
        end
      end
    end
  end
end
