FactoryBot.define do
  factory :proposal do
    transient do
      games { [] }
    end

    game_one { games.first }
    game_two { games.second }
  end
end
