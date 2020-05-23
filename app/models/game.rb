class Game
  attr_accessor :id

  def ==(other)
    id == other.id
  end

  def inspect
    "<Game ID:#{id}>"
  end
end
