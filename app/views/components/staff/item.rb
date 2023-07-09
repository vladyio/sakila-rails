module Views
  module Components
    class Staff::Item < ApplicationComponent
      def initialize(staff)
        @staff = staff
      end

      def template(&)
        a(class: 'item-card group') do
          h1(class: 'item-card--title') { "#{@staff.first_name} #{@staff.last_name}" }
          span(class: 'item-card--rating') { @staff.active ? 'active' : 'disabled' }
          div(class: 'item-card--description mt-3') do
            p { @staff.username }
            p { @staff.store.address.address }
          end
        end
      end
    end
  end
end
