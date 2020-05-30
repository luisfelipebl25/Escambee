module GamesHelper
  def find_game(fetcher, id, resource)
    game = fetcher.fetch(id)
    case resource
    when 'image'
      game.image['original_url']
    when 'name'
      game.name
    end
  end
end
