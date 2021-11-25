# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Player.create!(first_name: "Ianiv",
               last_name: "Hojman",
               email: "ihojmanb@yahoo.com")

30.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "fake_email_#{n+1}@nnodes.com"
  
  Player.create!(first_name: first_name,
               last_name: last_name,
               email: email)
end
