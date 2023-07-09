module Views
  module Components
    class Cities::Item < ApplicationComponent
      def initialize(city)
        @city = city
      end

      def template(&)
        a(class: 'item-card group') do
          h1(class: 'item-card--title') { @city.city }
          div(class: 'item-card--description') { @city.country.country }
        end
      end
    end
  end
end
