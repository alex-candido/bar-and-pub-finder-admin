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

csv_file_path = Rails.root.join("db", "data", "places.csv")

puts "Creating places..."

total_count = 0
error_count = 0

CSV.foreach(csv_file_path, headers: true) do |row|
  Place.create!(
    name: row["name"],
    description: row["description"],
    latitude: row["latitude"].to_f,
    longitude: row["longitude"].to_f,
    type: row["type"].downcase.to_sym,
    status: row["status"].downcase.to_sym
  )
  total_count += 1
rescue StandardError => e
  error_count += 1
  puts "Error creating place: #{row['name']}"
  puts "Error message: #{e.message}"
end

puts "Completed place creation!"
puts "Successfully created: #{total_count} places"
puts "Errors encountered: #{error_count}"
