# frozen_string_literal: true

module Views
  module Components
    class Dashboard::Grid < ApplicationComponent
      def initialize(collection)
        @collection = collection
      end

      def template
        div(id: 'items', class: 'h-full ml-[235px] grid md:grid-cols-3 gap-1') do
          @collection.each { |item| render grid_component(item.class, item) }
        end
      end

      def grid_component(model, item)
        "Views::Components::#{model}".constantize.new(item)
      end
    end
  end
end
