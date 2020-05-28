class Match < ApplicationRecord
  attr_accessor :answers

  belongs_to :forward_user, class_name: User
  belongs_to :backward_user, class_name: User
  belongs_to :proposal

  after_initialize do
    @answers = []
  end

  def users
    [forward_user, backward_user]
  end

  def confirmed?
    forward_user.answer(proposal).accepted? && backward_user.answer(proposal).accepted?
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
