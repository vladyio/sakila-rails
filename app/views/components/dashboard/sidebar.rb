# frozen_string_literal: true

module Views
  module Components
    class Dashboard::Sidebar < ApplicationComponent
      def initialize(models)
        @models = models
      end

      def template(&)
        nav(class: 'navbar inline') do
          ul(class: 'relative m-0 list-none px-[0.2rem] w-full') do
            @models.each do |model|
              render Dashboard::SidebarItem.new(model)
            end
          end
        end
      end
    end
  end
end
