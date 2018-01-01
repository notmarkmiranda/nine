FactoryBot.define do
  factory :user do
    sequence :email { |n| "email#{n}@example.com" }
    first_name 'John'
    last_name 'Doe'
    password 'password'

    trait :invited do
      invited true
    end

    trait :not_invited do
      invited false
    end
  end
end
