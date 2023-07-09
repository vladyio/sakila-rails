module Views
  module Components
    class Customers::Item < ApplicationComponent
      def initialize(customer)
        @customer = customer
      end

      def template(&)
        a(class: 'item-card group') do
          h1(class: 'item-card--title') { "#{@customer.first_name} #{@customer.last_name}" }
          span(class: 'item-card--rating') { "#{@customer.active ? 'active' : 'disabled'}" }
          div(class: 'item-card--description mt-3') do
            p { @customer.email.downcase }
            p { @customer.address.address }
          end
        end
      end
    end
  end
end
