class Match
  attr_accessor :proposal, :user_forward, :user_backward

  def initialize(proposal, user_forward, user_backward)
    @proposal = proposal
    @user_forward = user_forward
    @user_backward = user_backward
  end

  def users
    [user_forward, user_backward]
  end
end
