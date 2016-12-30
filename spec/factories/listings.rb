FactoryGirl.define do
  factory :listing do
    user

    title { Faker::Beer.name }
    description { Faker::ChuckNorris.fact }
    price { Faker::Number.number(3) }
  end
end
