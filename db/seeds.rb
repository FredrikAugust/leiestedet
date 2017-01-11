locations = [
  # these are all google place-ids
  "EhNPc2xvIFBsYWRzLCBEYW5tYXJr",
  "EhZPc2xvIGdhdGUsIE9zbG8sIE5vcmdl",
  "EiBPc2xvZXIgU3RyYcOfZSwgQmVybGluLCBUeXNrbGFuZA",
  "EhtPc2xvdmVpZW4sIFRyb25kaGVpbSwgTm9yZ2U"
]

User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  telephone: '+12 345 67 890',
  location: 'Oslo, Norway',
  place_id: locations.sample,
  password: 'password', password_confirmation: 'password'
)

listings = Listing.create([
  {
    title: Faker::Beer.name,
    description: Faker::ChuckNorris.fact,
    price: Faker::Number.number(3),
    user: User.last
  },
  {
    title: Faker::Beer.name,
    description: Faker::ChuckNorris.fact,
    price: Faker::Number.number(3),
    user: User.last
  }
])
