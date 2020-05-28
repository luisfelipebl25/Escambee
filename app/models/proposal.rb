class Proposal < ApplicationRecord
  has_many :answers, class_name: 'ProposalAnswer'

  def first_game
    Game.new first_game_id
  end

  def second_game
    Game.new second_game_id
  end

  def answer(user, answer)
    return false unless able_to_accept?(user)
    return false if answers.where(user: user).any?

    ProposalAnswer.create(proposal: self, user: user, answer: answer)
    user.reload
    self.reload

    true
  end

  def positive_answers
    answers.select(&:accepted?)
  end

  def ==(other)
    games.sort == other.games.sort
  end

  def able_to_accept?(user)
    return true if user.wishes?(first_game) && user.owns?(second_game)
    return true if user.wishes?(second_game) && user.owns?(first_game)

    false
  end

  def games
    [first_game, second_game]
  end
end
