class Proposal < ApplicationRecord
  attr_accessor :answers

  after_initialize do
    @answers = []
  end

  def first_game
    Game.new first_game_id
  end

  def second_game
    Game.new second_game_id
  end

  def answer(user, answer)
    return false unless able_to_accept?(user)
    return false if answers.any? { |ans| ans.user == user }

    proposal_answer = ProposalAnswer.new(self, user, answer)
    user.proposal_answers.push proposal_answer
    answers.push proposal_answer

    true
  end

  def positive_answers
    answers.select(&:accepted?)
  end

  def ==(other)
    first_game == other.first_game && second_game == other.second_game
  end

  def able_to_accept?(user)
    return true if user.wishes?(first_game) && user.owns?(second_game)
    return true if user.wishes?(second_game) && user.owns?(first_game)

    false
  end
end
