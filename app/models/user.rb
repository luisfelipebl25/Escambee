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

  def has?(game)
    ownlist.include? game
  end

  def accepted?(proposal)
    answers.find { |answer| answer.proposal == proposal }&.answer
  end

  def ==(other)
    name == other.name
  end
end
