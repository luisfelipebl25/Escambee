class Proposal
  attr_accessor :game_one, :game_two
  def initialize(game_one = nil, game_two = nil)
    @game_one = game_one
    @game_two = game_two
  end

  def answer(user, answer)
    return false unless able_to_accept?(user)

    proposal_answer = ProposalAnswer.new(self, user, answer)
    user.answers.push proposal_answer

    true
  end

  def ==(other)
    game_one == other.game_one && game_two == other.game_two
  end

  def able_to_accept?(user)
    return true if user.wishes?(game_one) && user.owns?(game_two)
    return true if user.wishes?(game_two) && user.owns?(game_one)

    false
  end
end
