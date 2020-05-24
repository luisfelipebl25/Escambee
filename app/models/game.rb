class Game
  attr_accessor :id
  attr_accessor :who_owns, :who_wishes

  def ==(other)
    id == other.id
  end
end
