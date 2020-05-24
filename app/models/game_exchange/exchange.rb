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
      @user_one.do_exchange(@proposal)
      @user_two.do_exchange(@proposal)
    end
  end
end
