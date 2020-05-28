FactoryBot.define do
  factory :transaction do
    transient do
      games { build_list :game, 2 }
    end
    user { create(:user) }
    given { games.first }
    received { games.second }

    after(:build) do |transaction, options|
      transaction.user.ownlist.push options.games.first
      transaction.user.wishlist.push options.games.second
    end
  end
end
