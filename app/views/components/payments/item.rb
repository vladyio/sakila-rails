module Views
  module Components
    class Payments::Item < ApplicationComponent
      def initialize(payment)
        @payment = payment
      end

      # rubocop:disable Metrics
      def template(&)
        a(class: 'item-card group') do
          h1(class: 'item-card--title') { "$ #{@payment.amount.to_f}" }
          span(class: 'item-card--rating') { "Paid: #{@payment.payment_date.strftime('%d.%m.%Y')}" }
          div(class: 'item-card--description mt-3') do
            span { 'Customer: ' }
            span { "#{@payment.customer.first_name} #{@payment.customer.last_name}" }
            br
            span { 'Rented at: ' }
            span { @payment.rental.rental_date.strftime('%d.%m.%Y') }
          end
        end
      end
    end
  end
end
