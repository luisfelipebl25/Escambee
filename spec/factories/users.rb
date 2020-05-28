FactoryBot.define do
  factory :user do
    transient do
      wishes { [] }
      owns { [] }
    end

    name { Faker::Name.name_with_middle }
    email { Faker::Internet.email(name: name) }
    password { Faker::Internet.password }
    password_confirmation { password }

    after(:build) do |user, options|
      options.wishes.each { |wish| user.wishlist.push wish }
      options.owns.each { |own| user.ownlist.push own }
    end
  end
end
