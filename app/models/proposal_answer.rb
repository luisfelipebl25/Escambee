class ProposalAnswer
  attr_accessor :proposal
  attr_accessor :user
  attr_accessor :answer

  def initialize(proposal, user, answer)
    @proposal = proposal
    @user = user
    @answer = answer
  end
end
