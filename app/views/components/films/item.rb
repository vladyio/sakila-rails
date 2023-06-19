module Components
  class Film < ApplicationComponent
    def initialize(film)
      @title = film.title
      @rating = film.rating
      @description = film.description
    end

    def template(&)
      a(class: 'film-card group') do
        h1(class: 'film-card--title') { @title }
        span(class: 'film-card--rating inline-flex my-3 py-2') { "Rating: #{@rating}" }
        p(class: 'film-card--description') { @description }
      end
    end
  end
end
