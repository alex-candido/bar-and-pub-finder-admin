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

puts "Create a default admin user"
admin = User.admin.find_or_initialize_by(email: "admin@mail.com", name: "Admin", username: "User")
admin.password = "123456"
admin.password_confirmation = admin.password
admin.save!

puts "Creating registered users..."
FactoryBot.build_list(:user, 15).each do |user|
  user.email = Faker::Internet.email
  user.name = Faker::Name.name
  user.username = Faker::Internet.username
  user.password = "123456"
  user.password_confirmation = user.password
  user.registered!
end
