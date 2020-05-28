class Own < ApplicationRecord
  belongs_to :user

  validates_presence_of :user, :game_id
  # TODO: Adicionar validações que não permitem armazenar em game_id algo que não seja números

  def game
    Game.new game_id
  end
end
