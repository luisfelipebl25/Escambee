class Proposal
  attr_accessor :game_one, :game_two

  # Aceita trocar game_one por game_two
  attr_accessor :accepts_forward

  # Aceita trocar game_two por game_one
  attr_accessor :accepts_backwards

  def answer(user, answer)
    proposal_answer = ProposalAnswer.new(self, user, answer)

    user.answers.push proposal_answer
  end
end
