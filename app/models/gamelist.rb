# frozen_string_literal: true

class Gamelist
  include Enumerable
  delegate :to_a, :empty?, to: :list

  def initialize(user, method, entity)
    @user = user
    @method = method
    @another_method = %i[wishes owns].find { |m| m != method }
    @entity = entity
  end

  def each(&block)
    list.each(&block)
  end

  def push(game)
    entity = @entity.new game_id: game.id
    return if user_another_method.where(game_id: game.id).any?

    user_method.push entity unless entity.valid?
  end

  def delete(game)
    user_method.where(game_id: game.id).first.destroy!
    user_method.reload
  end

  private

  def user_method
    @user.method(@method).call
  end

  def user_another_method
    @user.method(@another_method).call
  end

  def list
    user_method.map { |wish| Game.new wish.game_id }
  end
end
