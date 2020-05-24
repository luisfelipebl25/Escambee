class Wishlist
  include Enumerable
  delegate :empty?, :delete, to: :list

  def initialize(user)
    @list = []
    @user = user
  end

  def each(&block)
    @list.each(&block)
  end

  def push(game)
    @list.push game

    game.who_wishes.push @user
  end

  private

  def list
    @list
  end
end
