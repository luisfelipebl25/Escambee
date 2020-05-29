class ProposalAnswer < ApplicationRecord
  belongs_to :proposal
  belongs_to :user
  enum direction: [:forward, :backward]

  validates_presence_of :direction
  validates_inclusion_of :answer, in: [true, false]

  before_validation do
    self.direction = proposal_direction
  end

  def accepted?
    answer
  end

  def transaction
    return unless accepted?

    Transaction.new(
      user: user,
      proposal: proposal
    )
  end

  def forward?
    direction.to_sym == :forward
  end

  def backward?
    !forward?
  end

  def to_give
    forward? ? proposal.first_game : proposal.second_game
  end

  def to_receive
    forward? ? proposal.second_game : proposal.first_game
  end

  private

  def proposal_direction
    return nil if user.nil? || proposal.nil?

    if user.owns?(proposal.first_game) && user.wishes?(proposal.second_game)
      :forward
    elsif user.owns?(proposal.second_game) && user.wishes?(proposal.first_game)
      :backward
    end
  end
end
