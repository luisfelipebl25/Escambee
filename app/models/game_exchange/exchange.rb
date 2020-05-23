module GameExchange
  class Exchange
    def initialize(user_one, user_two, proposal)
      @user_one = user_one
      @user_two = user_two
      @proposal = proposal
    end

    def matched?
      @user_one.accepted?(@proposal) && @user_two.accepted?(@proposal)
    end

    def exchange
      game_one = @proposal.game_one
      game_two = @proposal.game_two

      if @user_one.owns?(game_one) && @user_two.owns?(game_two)
        @user_one.exchange(game_one, game_two)
        @user_two.exchange(game_two, game_one)
      elsif @user_two.owns?(game_two) && @user_two.owns?(game_one)
        @user_one.exchange(game_two, game_one)
        @user_two.exchange(game_one, game_two)
      end
    end
  end
end
