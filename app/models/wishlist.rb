class Wishlist
  include Enumerable
  delegate :empty?, to: :list

  def initialize(user)
    @list = user.wishes.map { |wish| Game.new wish.game_id }
    @user = user
  end

  def each(&block)
    @list.each(&block)
  end

  def push(game)
    @list.push game
    @user.wishes.push Wish.new game_id: game.id
  end

  def delete(game)
    @list.delete game

    @user.wishes.where(game_id: game.id).first.destroy!
  end

  private

  def list
    @list
  end
end
