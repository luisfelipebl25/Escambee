module GameExchange
  class Matcher
    def initialize(games)
      @games = games
    end

    def proposals
      proposals = []

      @games.each_with_index do |game, index|
        @games[index..-1].each do |another_game|
          if game != another_game && proposable(game, another_game)
            proposals.push Proposal.new first_game_id: game.id, second_game_id: another_game.id
          end
        end
      end

      proposals.select(&:valid?)
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
            Match.new(proposal: proposal, forward_user: answer.user, backward_user: answer_two.user)
          end
        end
      end.flatten
    end

    def has_matches?(proposal)
      proposal.answers.any?(&:forward?) && proposal.answers.any?(&:backward?)
    end

    def confirmed_matches(matches)
      matches.select(&:confirmed?)
    end
  end
end
