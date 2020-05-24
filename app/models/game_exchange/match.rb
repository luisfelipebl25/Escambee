module GameExchange
  class Match
    def initialize(games)
      @games = games
    end

    def proposals
      proposals = []
      @games.each do |game|
        @games.each do |another_game|
          if game != another_game && proposable(game, another_game)
            proposals.push Proposal.new game, another_game
          end
        end
      end

      proposals
    end

    def proposable(game, another_game)
      aux = game.who_wishes & another_game.who_owns
      auy = another_game.who_wishes & game.who_owns

      aux.any? && auy.any?
    end
  end
end
