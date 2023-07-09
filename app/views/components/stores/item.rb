module Views
  module Components
    class Stores::Item < ApplicationComponent
      def initialize(store)
        @store = store
      end

      def template(&)
        a(class: 'item-card group') do
          h1(class: 'item-card--title') { @store.address.address }
          div(class: 'item-card--description mt-3') do
            p { "#{@store.manager_staff.first_name} #{@store.manager_staff.last_name}" }
          end
        end
      end
    end
  end
end
