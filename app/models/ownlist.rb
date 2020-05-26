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

    game.who_owns.push @user
  end

  private

  def list
    @list
  end
end
