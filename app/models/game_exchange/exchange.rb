module GameExchange
  class Exchange
    def initialize(user_one, user_two, proposal)
      @user_one = user_one
      @user_two = user_two
      @proposal = proposal
    end

    def users
      [@user_one, @user_two]
    end

    def matched?
      all_accepted? && no_conflict?
    end

    def all_accepted?
      users.all? { |user| user.accepted?(@proposal) }
    end

    def no_conflict?
      @user_one.answer(@proposal).direction != @user_two.answer(@proposal).direction
    end

    def exchange
      return false unless matched?

      users.each { |user| user.exchange(@proposal) }
    end
  end
end
