class Own < ApplicationRecord
  belongs_to :user

  def game
    Game.new game_id
  end
end
