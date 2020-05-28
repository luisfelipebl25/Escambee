class Wishlist
  include Enumerable
  delegate :empty?, to: :list

  def initialize(user)
    @user = user
  end

  def each(&block)
    list.each(&block)
  end


  def push(game)
    @user.wishes.push Wish.new game_id: game.id
  end

  def delete(game)
    @user.wishes.where(game_id: game.id).first.destroy!
    @user.wishes.reload
  end

  private

  def list
    @user.wishes.map { |wish| Game.new wish.game_id }
  end
end
