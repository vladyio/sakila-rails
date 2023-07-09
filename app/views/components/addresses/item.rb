module Views
  module Components
    class Addresses::Item < ApplicationComponent
      def initialize(address)
        @address = address
      end

      def template(&)
        a(class: 'item-card group') do
          h1(class: 'item-card--title') { @address.address }
          span(class: 'item-card--rating') { "Code: #{@address.postal_code}" }
          div(class: 'item-card--description mt-3') do
            p { @address.district }
            p { @address.phone }
          end
        end
      end
    end
  end
end
