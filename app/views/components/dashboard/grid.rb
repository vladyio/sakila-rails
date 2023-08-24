# frozen_string_literal: true

module Views
  module Components
    class Dashboard::Grid < ApplicationComponent
      include Phlex::Rails::Helpers::TurboFrameTag

      def initialize(collection, pagy)
        @collection = collection
        @pagy = pagy
      end

      # rubocop:disable Metrics/MethodLength
      def template
        div(id: 'items', class: 'h-full min-h-screen ml-[235px]') do
          turbo_frame_tag("collection_#{@pagy.page}") do
            div(class: 'grid md:grid-cols-3') do
              @collection.each { |item| render grid_component(item.class, item) }
            end

            unless @pagy.page == @pagy.pages
              turbo_frame_tag("collection_#{@pagy.next}",
                              src: helpers.dashboard_index_path(page: @pagy.next, model: collection_class),
                              loading: 'lazy')
            end
          end
        end
      end

      def grid_component(model, item)
        "#{model.to_s.pluralize}::Item".constantize.new(item)
      end

      private

      def collection_class
        @collection.first.class
      end
    end
  end
end
