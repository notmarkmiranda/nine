FactoryBot.define do
  factory :game do
    season
    attendees 10
    buy_in 100
    creator

    trait :private do
      private true
    end

    trait :public do
      private false
    end
  end
end
