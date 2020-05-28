class Game
  attr_accessor :id

  def initialize(id = nil)
    @id = id
  end

  def ==(other)
    id == other.id
  end

  def who_owns
    User.joins(:owns).where(owns: { game_id: id })
  end

  def who_wishes
    User.joins(:wishes).where(wishes: { game_id: id})
  end
end
