class Game
  attr_accessor :id

  def ==(other)
    id == other.id
  end
end
