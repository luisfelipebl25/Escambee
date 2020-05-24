FactoryBot.define do
  factory :user do
    transient do
      wishes { [] }
      owns { [] }
    end

    name { Faker::Name.name_with_middle }

    after(:build) do |user, options|
      options.wishes.each { |wish| user.wishlist.push wish }
      options.owns.each { |own| user.ownlist.push own }
    end
  end
end
