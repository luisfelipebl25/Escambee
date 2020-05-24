class ProposalAnswer
  attr_accessor :proposal
  attr_accessor :user
  attr_accessor :direction

  def initialize(proposal, user, answer)
    @proposal = proposal
    @user = user
    @answer = answer
    @direction = define_direction(user, proposal)
  end

  def accepted?
    @answer
  end

  def transaction
    return unless accepted?

    Transaction.new(@user, to_give, to_receive)
  end

  def forward?
    @direction == :forward
  end

  private

  def to_give
    forward? ? proposal.game_one : proposal.game_two
  end

  def to_receive
    forward? ? proposal.game_two : proposal.game_one
  end

  def define_direction(user, proposal)
    if user.owns?(proposal.game_one) && user.wishes?(proposal.game_two)
      :forward
    elsif user.owns?(proposal.game_two) && user.wishes?(proposal.game_one)
      :backward
    end
  end
end
