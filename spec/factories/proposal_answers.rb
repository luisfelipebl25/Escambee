FactoryBot.define do
  factory :proposal_answer do
    transient do
      games { build_list :game, 2 }
      forward { true }
    end
    proposal { build :proposal, games: games }
    user { build :user }
    answer { [false, true].sample }

    trait :backwards_user do
      forward { false }
    end

    after(:build) do |obj, opts|
      games = opts.forward ? opts.games : opts.games.reverse
      next if obj.user.nil?

      obj.user.ownlist.push games.first if obj.user.ownlist.empty?
      obj.user.wishlist.push games.second if obj.user.wishlist.empty?
    end
  end
end
