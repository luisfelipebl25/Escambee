FactoryBot.define do
  factory :proposal do
    transient do
      games { [] }
    end

    first_game_id { games.first.id }
    second_game_id { games.second.id }
  end
end
