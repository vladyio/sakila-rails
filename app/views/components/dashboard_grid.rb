# frozen_string_literal: true

module Views
  module Components
    class DashboardGrid < ApplicationComponent
      def initialize(collection)
        @collection = collection
      end

      def template
        div(id: 'items', class: 'h-full ml-[235px] grid md:grid-cols-3 gap-1') do
          @collection.each { |item| render dashboard_component(item.class, item) }
        end
      end

      def dashboard_component(model, item)
        "Views::Components::#{model}".constantize.new(item)
      end
    end
  end
end
