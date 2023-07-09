module Views
  module Components
    class Rentals::Item < ApplicationComponent
      def initialize(rental)
        @rental = rental
      end

      def template(&)
        a(class: 'item-card group') do
          h1(class: 'item-card--title') { @rental.rental_date.strftime('%d.%m.%Y') }
          div(class: 'item-card--description mt-3') do
            p { "#{@rental.customer.first_name} #{@rental.customer.last_name}" }
          end
        end
      end
    end
  end
end
