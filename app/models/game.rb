class Game
  attr_accessor :id
  attr_accessor :who_owns, :who_wishes

  def initialize
    @who_wishes = []
    @who_owns = []
  end

  def ==(other)
    id == other.id
  end
end
