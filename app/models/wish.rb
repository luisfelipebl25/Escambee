class Wish < ApplicationRecord
  belongs_to :user, autosave: true

  def game
    Game.new game_id
  end
end
