class Wish < ApplicationRecord
  belongs_to :user, autosave: true

  validates_presence_of :user, :game_id
  validates_uniqueness_of :game_id, scope: [:user_id]

  validates :game_id, numericality: { only_integer: true }

  def game
    Game.new game_id
  end
end
