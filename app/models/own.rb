class Own < ApplicationRecord
  belongs_to :user

  validates_presence_of :user, :game_id

  def game
    Game.new game_id
  end
end
