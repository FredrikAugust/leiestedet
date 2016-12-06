# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([
  {
    first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'password', password_confirmation: 'password'
  }
])

listings = Listing.create([
  {
    title: Faker::Beer.name,
    description: Faker::ChuckNorris.fact,
    location: Faker::GameOfThrones.city,
    price: Faker::Number.number(3),
    user: User.first
  },
  {
    title: Faker::Beer.name,
    description: Faker::ChuckNorris.fact,
    location: Faker::GameOfThrones.city,
    price: Faker::Number.number(3),
    user: User.first
  }
])
