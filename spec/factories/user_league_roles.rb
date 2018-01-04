FactoryBot.define do
  factory :user_league_role do
    league
    user

    trait :member do
      role 0
    end

    trait :admin do
      role 1
    end
  end
end
