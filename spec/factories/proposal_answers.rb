FactoryBot.define do
  factory :proposal_answer do
    proposal { build :proposal }
  end
end
