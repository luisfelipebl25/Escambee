class Ownlist
  include Enumerable
  delegate :empty?, :delete, to: :list

  def initialize(user)
    @list = user.owns.map { |wish| Game.new wish.game_id }
    @user = user
  end

  def each(&block)
    @list.each(&block)
  end

  def push(game)
    @list.push game
    @user.owns.push Own.new game_id: game.id

    game.who_owns.push @user
  end

  def delete(game)
    @list.delete game

    own = @user.owns.where(game_id: game.id).first
    own.destroy!

    game.who_owns.delete @user
  end

  private

  def list
    @list
  end
end
