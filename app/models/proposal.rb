class Proposal
  attr_accessor :game_one, :game_two

  # Aceita trocar game_one por game_two
  attr_accessor :accepts_forward

  # Aceita trocar game_two por game_one
  attr_accessor :accepts_backwards

  def answer(user, answer)
    return false unless able_to_accept?(user)

    proposal_answer = ProposalAnswer.new(self, user, answer)
    user.answers.push proposal_answer

    true
  end

  def able_to_accept?(user)
    return true if user.wishes?(game_one) && user.has?(game_two)
    return true if user.wishes?(game_two) && user.has?(game_one)

    false
  end
end
