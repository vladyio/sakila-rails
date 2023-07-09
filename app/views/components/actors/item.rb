module Views
  module Components
    class Actor < ApplicationComponent
      def initialize(actor)
        @first_name = actor.first_name
        @last_name = actor.last_name
      end

      def template(&)
        a(class: 'item-card group') do
          h1(class: 'item-card--title') { "#{@first_name} #{@last_name}" }
        end
      end
    end
  end
end
