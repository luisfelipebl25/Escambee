FactoryBot.define do
  factory :transaction do
    transient do
      games { build_list :game, 2 }
    end

    user { create :user, owns: [games.first], wishes: [games.second] }
    proposal { create :proposal, games: games }

    after(:build) do |transaction|
      transaction.user.proposal_answers.push build(:proposal_answer, proposal: transaction.proposal, user: transaction.user, answer: true)
    end
  end
end
