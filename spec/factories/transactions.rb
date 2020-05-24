FactoryBot.define do
  factory :transaction do
    user { build(:user, ownlist: [1], wishlist: [2]) }
    given { 1 }
    received { 2 }

    initialize_with { Transaction.new(user, given, received) }
  end
end
