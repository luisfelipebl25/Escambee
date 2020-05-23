FactoryBot.define do
  factory :game do
    id { Faker::Number.number(digits: 5) }
  end
end
