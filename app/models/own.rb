class Own < ApplicationRecord
  belongs_to :user

  validates_presence_of :user, :game_id

  validates :game_id, numericality: { only_integer: true }

  def game
    Game.new game_id
  end
end
