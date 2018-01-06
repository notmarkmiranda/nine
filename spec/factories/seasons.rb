FactoryBot.define do
  factory :season do
    league

    trait :inactive do
      active false
    end

    trait :completed do
      completed true
    end

    factory :inactive_and_completed_season, traits: [:inactive, :completed]
    factory :inactive, traits: [:inactive]
    factory :completed, traits: [:completed]
  end
end
