class MoviesController < ApplicationController 
    def index
        @movies = Movie.includes(:reviews).all
    
        @movies = @movies.map do |movie|
          {
            id: movie.id,
            title: movie.title,
            year: movie.year,
            director: movie.director,
            country: movie.country,
            average_stars: calculate_average(movie.reviews)
          }
        end
    
        @movies = @movies.sort_by { |movie| -movie[:average_stars] }
    
        render json: @movies
      end
    
    def search_by_actor
        actor = params[:actor]
        @movies = Movie.where('actor LIKE ?', "%#{actor}%")
    
        render json: @movies
    end

      private
    
      def calculate_average(reviews)
        return 0 if reviews.empty?
    
        total_stars = reviews.sum(&:stars)
        total_reviews = reviews.count.to_f
    
        (total_stars / total_reviews).round(2)
      end    
    
end
