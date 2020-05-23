FactoryBot.define do
  factory :proposal do
    game_one { build :game }
    game_two { build :game }
  end
end
