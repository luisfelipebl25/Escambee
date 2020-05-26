module GameExchange
  class Matcher
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

      proposals.uniq
    end

    def proposable(game, another_game)
      aux = game.who_wishes & another_game.who_owns
      auy = another_game.who_wishes & game.who_owns

      aux.any? && auy.any?
    end

    def generate_matches(proposals)
      proposals.select { |proposal| has_matches? proposal}.map do |proposal|
        proposal.positive_answers.select(&:forward?).map do |answer|
          proposal.positive_answers.select(&:backward?).map do |answer_two|
            Match.new(proposal, answer.user, answer_two.user)
          end
        end
      end.flatten
    end

    def has_matches?(proposal)
      proposal.answers.any?(&:forward?) && proposal.answers.any?(&:backward?)
    end
  end
end
