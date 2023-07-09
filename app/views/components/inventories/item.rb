module Views
  module Components
    class Inventories::Item < ApplicationComponent
      def initialize(inventory)
        @inventory = inventory
      end

      def template(&)
        a(class: 'item-card group') do
          h1(class: 'item-card--title') { @inventory.film.title }
          div(class: 'item-card--description mt-3') { @inventory.store.address.address }
        end
      end
    end
  end
end
