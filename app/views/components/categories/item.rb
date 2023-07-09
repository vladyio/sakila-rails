module Views
  module Components
    class Categories::Item < ApplicationComponent
      def initialize(category)
        @category = category
      end

      def template(&)
        a(class: 'item-card group') do
          h1(class: 'item-card--title') { @category.name }
        end
      end
    end
  end
end
