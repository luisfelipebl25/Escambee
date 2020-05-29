FactoryBot.define do
  factory :proposal do
    transient do
      games { build_list :game, 2 }
    end

    first_game_id { games.first.id }
    second_game_id { games.second.id }
  end
end
