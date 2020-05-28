class Match
  attr_accessor :proposal, :user_forward, :user_backward
  attr_accessor :answers

  def initialize(proposal, user_forward, user_backward)
    @proposal = proposal
    @user_forward = user_forward
    @user_backward = user_backward
    @answers = []
  end

  def users
    [user_forward, user_backward]
  end

  def confirmed?
    user_forward.answer(proposal).accepted? && user_backward.answer(proposal).accepted?
  end

  def answer(user, answer)
    return false if answers.any? { |ans| ans.user == user }
    return false unless able_to_accept?(user)

    match_answer = MatchAnswer.new(proposal, user, answer)
    user.match_answers.push match_answer
  end

  def able_to_accept?(user)
    users.include? user
  end
end
