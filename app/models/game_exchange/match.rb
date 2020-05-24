module GameExchange
  class Match
    def initialize(games)
      @games = games
    end

    def proposals
    end

    def proposable(game_one, game_two)
      aux = game_one.who_wishes & game_two.who_owns
      auy = game_two.who_wishes & game_one.who_owns

      aux.any? && auy.any?
    end
  end
end
