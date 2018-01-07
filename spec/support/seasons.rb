FactoryBot.define do
  factory :season do
    league

    trait :completed do
      completed true
    end

    trait :inactive do
      active false
    end

    factory :inactive_and_complete, traits: [:inactive, :complete]
  end
end
