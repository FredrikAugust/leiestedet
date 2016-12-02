# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([
  {
    first_name: 'Test', last_name: 'User', email: 'test@test.com',
    password: 'password', password_confirmation: 'password'
  }
])

listings = Listing.create([
  {
    title: 'Test post please ignore',
    description: 'This is a test post, please ignore it.',
    location: 'Oslo, Norway',
    price: 100,
    user: User.where(email: 'test@test.com').first
  }
])
