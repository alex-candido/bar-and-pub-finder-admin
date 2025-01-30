# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#

require "csv"

ADMIN_EMAIL = "admin@mail.com"
CSV_PATH = Rails.root.join("db", "data", "places.csv")
DEFAULT_PASSWORD = "123456"
SAMPLE_USERS_COUNT = 15

puts "Create a default admin user"
admin = User.admin.find_or_initialize_by(
  email: ADMIN_EMAIL,
  name: "Admin",
  username: "User"
)
admin.assign_attributes(
  password: DEFAULT_PASSWORD,
  password_confirmation: DEFAULT_PASSWORD
)
admin.save!

puts "Creating registered users..."
users_created = 1
SAMPLE_USERS_COUNT.times do
  user = FactoryBot.build(:user,
    email: Faker::Internet.email,
    name: Faker::Name.name,
    username: Faker::Internet.username,
    password: DEFAULT_PASSWORD,
    password_confirmation: DEFAULT_PASSWORD
  )
  user.registered!
  users_created += 1
end
puts "#{users_created} users created"

puts "Creating places..."
places_data = []

CSV.foreach(CSV_PATH, headers: true) do |row|
  places_data << {
    name: row["name"],
    latitude: row["latitude"].to_f,
    longitude: row["longitude"].to_f,
    coords: Geo.point(row["latitude"].to_f, row["longitude"].to_f),
    info: row["info"].present? ? JSON.parse(row["info"]) : {},
  }
end

ActiveRecord::Base.transaction do
  Place.insert_all(places_data)
end
puts "#{places_data.count} places created"

puts "Database Seeding Completed"
