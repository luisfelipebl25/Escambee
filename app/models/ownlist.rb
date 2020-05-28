class Ownlist
  include Enumerable
  delegate :empty?, to: :list

  def initialize(user)
    @user = user
  end

  def each(&block)
    list.each(&block)
  end

  def push(game)
    @user.owns.push Own.new game_id: game.id
  end

  def delete(game)
    @user.owns.where(game_id: game.id).first.destroy!
    @user.owns.reload
  end

  private

  def list
    @user.owns.map { |wish| Game.new wish.game_id }
  end
end
