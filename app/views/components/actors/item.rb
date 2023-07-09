module Views
  module Components
    class Actor < ApplicationComponent
      def initialize(actor)
        @first_name = actor.first_name
        @last_name = actor.last_name
      end

      def template(&)
        a(class: 'film-card group') do
          h1(class: 'film-card--title') { "#{@first_name} #{@last_name}" }
        end
      end
    end
  end
end
