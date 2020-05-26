class MatchAnswer
  attr_accessor :match, :user, :answer

  def initialize(match, user, answer)
    @match = match
    @user = user
    @answer = answer
  end

  def accepted?
    @answer
  end
end
