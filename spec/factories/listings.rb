FactoryGirl.define do
  factory :listing do
    user

    title Faker::Beer.name
    description Faker::ChuckNorris.fact
    price Faker::Number.number(3)
    location Faker::GameOfThrones.city
  end
end
