class User
  attr_accessor :name
  attr_accessor :ownlist, :wishlist
  attr_accessor :answers
  attr_accessor :exchanges

  def initialize
    @answers = []
    @ownlist = []
    @wishlist = []
    @exchanges = []
  end

  def wishes?(game)
    wishlist.include? game
  end

  def owns?(game)
    ownlist.include? game
  end

  def exchange(owned, wished)
    wishlist.delete(wished)
    ownlist.delete(owned)
    ownlist.push wished
    exchanges.push Transaction.new(self, owned, wished)
  end

  def do_exchange(proposal)
    return unless accepted?(proposal)

    if answer(proposal).forward?
      exchange(proposal.game_one, proposal.game_two)
    else
      exchange(proposal.game_two, proposal.game_one)
    end
  end

  def answer(proposal)
    answers.find { |answer| answer.proposal == proposal }
  end

  def accepted?(proposal)
    answer(proposal)&.answer
  end

  def ==(other)
    name == other.name
  end
end
