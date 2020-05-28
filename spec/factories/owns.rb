FactoryBot.define do
  factory :own do
    game_id { Faker::Number.number(digits: 5).to_s }
    user { build :user }
  end
end
