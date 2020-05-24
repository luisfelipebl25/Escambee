class User
  attr_accessor :name
  attr_accessor :ownlist, :wishlist
  attr_accessor :answers
  attr_accessor :exchanges

  def initialize
    @answers = []
    @ownlist = Ownlist.new self
    @wishlist = Wishlist.new self
    @exchanges = []
  end

  def wishes?(game)
    wishlist.include? game
  end

  def proposals(proposals)
    proposals.select { |proposal| proposal.able_to_accept? self }
  end

  def owns?(game)
    ownlist.include? game
  end

  def exchange(proposal)
    return unless accepted?(proposal)

    answer(proposal).transaction.execute
  end

  def answer(proposal)
    answers.find { |answer| answer.proposal == proposal }
  end

  def accepted?(proposal)
    answer(proposal)&.accepted?
  end

  def ==(other)
    name == other.name
  end
end
