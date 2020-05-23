class User
  attr_accessor :name
  attr_accessor :ownlist, :wishlist
  attr_accessor :answers

  def initialize
    @answers = []
    @ownlist = []
    @wishlist = []
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
  end

  def accepted?(proposal)
    answers.find { |answer| answer.proposal == proposal }&.answer
  end

  def ==(other)
    name == other.name
  end
end
