class ProposalAnswer < ApplicationRecord
  belongs_to :proposal
  belongs_to :user
  enum direction: [:forward, :backward]

  before_save do
    direction = define_direction(user, proposal)
  end

  def direction
    define_direction(user, proposal)
  end

  def accepted?
    answer
  end

  def transaction
    return unless accepted?

    Transaction.new(
      user: user,
      given_game_id: to_give.id,
      received_game_id: to_receive.id
    )
  end

  def forward?
    direction == :forward
  end

  def backward?
    !forward?
  end

  private

  def to_give
    forward? ? proposal.first_game : proposal.second_game
  end

  def to_receive
    forward? ? proposal.second_game : proposal.first_game
  end

  def define_direction(user, proposal)
    if user.owns?(proposal.first_game) && user.wishes?(proposal.second_game)
      :forward
    elsif user.owns?(proposal.second_game) && user.wishes?(proposal.first_game)
      :backward
    end
  end
end
