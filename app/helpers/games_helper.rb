module GamesHelper
  def find_game(id, resource)
    game = GiantBomb::Game.detail(id)
    case resource
    when 'image'
      game.image['original_url']
    when 'name'
      game.name
    end 
  end 
end
