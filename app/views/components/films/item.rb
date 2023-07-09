module Views
  module Components
    class Film < ApplicationComponent
      def initialize(film)
        @title = film.title
        @rating = film.rating
        @description = film.description
      end

      def template(&)
        a(class: 'item-card group') do
          h1(class: 'item-card--title') { @title }
          span(class: 'item-card--rating inline-flex my-3 py-2') { "Rating: #{@rating}" }
          p(class: 'item-card--description') { @description }
        end
      end
    end
  end
end
