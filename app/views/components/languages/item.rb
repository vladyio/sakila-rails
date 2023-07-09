module Views
  module Components
    class Languages::Item < ApplicationComponent
      def initialize(language)
        @language = language
      end

      def template(&)
        a(class: 'item-card group') do
          h1(class: 'item-card--title') { @language.name }
        end
      end
    end
  end
end
