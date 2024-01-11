# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'csv'

CSV.foreach('movies.csv', headers: true) do |row|
  Movie.create!(
    title: row['Movie'],
    description: row['Description'],
    year: row['Year'].to_i,
    director: row['Director'],
    actor: row['Actor'],
    filming_location: row['Filming location'],
    country: row['Country']
  )
end


CSV.foreach('reviews.csv', headers: true) do |row|
    movie = Movie.find_by(title: row['Movie'])
    Review.create!(
      stars: row['Stars'].to_i,
      review: row['Review'],
      user: row['User'],
      movie: movie
    )
  end