class ProposalAnswer
  attr_accessor :proposal
  attr_accessor :user
  attr_accessor :answer
  attr_accessor :direction

  def initialize(proposal, user, answer)
    @proposal = proposal
    @user = user
    @answer = answer
    @direction = define_direction(user, proposal)
  end

  def define_direction(user, proposal)
    if user.owns?(proposal.game_one) && user.wishes?(proposal.game_two)
      :forward
    elsif user.owns?(proposal.game_two) && user.wishes?(proposal.game_one)
      :backward
    end
  end
end
