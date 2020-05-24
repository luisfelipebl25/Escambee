FactoryBot.define do
  factory :transaction do
    transient do
      games { build_list :game, 2 }
    end
    user { build(:user, owns: [games.first], wishes: [games.second]) }
    given { games.first }
    received { games.second }

    initialize_with { new(user, given, received) }
  end
end
