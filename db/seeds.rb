# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


require "csv"

csv_file_path = Rails.root.join("db", "data", "places_cleaned.csv")

puts "Creating places..."

total_count = 0
error_count = 0

places_data = []

CSV.foreach(csv_file_path, headers: true) do |row|
  places_data << {
    name: row["name"],
    latitude: row["latitude"].to_f,
    longitude: row["longitude"].to_f,
    coords: Geo.point(row["latitude"].to_f, row["longitude"].to_f),
    info: row["info"].present? ? JSON.parse(row["info"]) : {}, 
  }

  total_count += 1
rescue StandardError => e
  error_count += 1
  puts "Error creating place: #{row['name']}"
  puts "Error message: #{e.message}"
end

Place.insert_all(places_data)

puts "Completed place creation!"
puts "Successfully created: #{total_count} places"
puts "Errors encountered: #{error_count}"
