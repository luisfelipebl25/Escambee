class Match < ApplicationRecord
  has_many :answers, class_name: 'MatchAnswer'

  belongs_to :forward_user, class_name: 'User'
  belongs_to :backward_user, class_name: 'User'
  belongs_to :proposal

  validates_uniqueness_of :forward_user, scope: [:backward_user, :proposal]

  def users
    [forward_user, backward_user]
  end

  def confirmed?
    forward_user.answer(proposal).accepted? && backward_user.answer(proposal).accepted?
  end

  def answer(user, answer)
    return false if answers.any? { |ans| ans.user == user }
    return false unless able_to_accept?(user)

    match_answer = MatchAnswer.new(match: self, user: user, answer: answer)
    user.match_answers.push match_answer
  end

  def able_to_accept?(user)
    users.include? user
  end
end
