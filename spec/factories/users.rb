FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { "#{first_name}.#{last_name}@example.com".downcase }
    telephone '12312312'
    place_id do
      [
        # these are all google place-ids
        "EhNPc2xvIFBsYWRzLCBEYW5tYXJr",
        "EhZPc2xvIGdhdGUsIE9zbG8sIE5vcmdl",
        "EiBPc2xvZXIgU3RyYcOfZSwgQmVybGluLCBUeXNrbGFuZA",
        "EhtPc2xvdmVpZW4sIFRyb25kaGVpbSwgTm9yZ2U"
      ].sample
    end
    location { Faker::Address.street_address }
    password 'password'
    password_confirmation { password }
  end
end
