# frozen_string_literal: true

module Views
  module Components
    class Dashboard::Grid < ApplicationComponent
      def initialize(collection)
        @collection = collection
      end

      def template
        div(id: 'items', class: 'h-full min-h-screen ml-[235px] grid md:grid-cols-3 gap-1') do
          @collection.each { |item| render grid_component(item.class, item) }
        end
      end

      def grid_component(model, item)
        "#{model.to_s.pluralize}::Item".constantize.new(item)
      end
    end
  end
end
