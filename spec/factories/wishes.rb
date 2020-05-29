FactoryBot.define do
  factory :wish do
    game_id { build(:game).id.to_s }
    user { build :user }
  end
end
