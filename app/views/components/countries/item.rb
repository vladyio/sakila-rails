module Views
  module Components
    class Countries::Item < ApplicationComponent
      def initialize(country)
        @country = country
      end

      def template(&)
        a(class: 'item-card group') do
          h1(class: 'item-card--title') { @country.country }
        end
      end
    end
  end
end
