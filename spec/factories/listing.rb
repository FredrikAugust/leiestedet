FactoryGirl.define do
  factory :listing do
    user

    title 'Brown Gown'
    description 'Very little used brown gown. In perfect condition.'
    price 100
    location 'Oslo, Norway'
  end
end
