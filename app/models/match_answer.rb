class MatchAnswer < ApplicationRecord
  belongs_to :match
  belongs_to :user

  def accepted?
    answer
  end
end
