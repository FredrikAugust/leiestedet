FactoryGirl.define do
  factory :user do
    first_name 'Jon'
    last_name 'Doe'
    email "#{first_name}.#{last_name}@example.com".downcase
    password 'password'
    password_confirmation password
  end
end
