class Wish < ApplicationRecord
  belongs_to :user, autosave: true

  validates_presence_of :user, :game_id

  def game
    Game.new game_id
  end
end
