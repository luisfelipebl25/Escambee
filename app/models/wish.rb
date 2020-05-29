class Wish < ApplicationRecord
  belongs_to :user, autosave: true

  validates_presence_of :user, :game_id
  validates :game_id, format: { with: /\A\d+\Z/ }

  def game
    Game.new game_id
  end
end
