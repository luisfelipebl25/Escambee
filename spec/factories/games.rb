FactoryBot.define do
  factory :game do
    id { Faker::Number.number(digits: 5).to_s }
  end
end
