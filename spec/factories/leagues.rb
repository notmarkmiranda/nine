FactoryBot.define do
  factory :league do
    sequence :name { |n| "League Number #{n}" }
    sequence :slug { |n| "league-number-#{n}" }
    creator

    trait :private do
      privated true
    end

    trait :public do
      privated false
    end
  end
end
