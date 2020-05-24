class Wishlist
  include Enumerable
  delegate :push, :empty?, to: :list

  def initialize
    @list = []
  end

  def each(&block)
    @list.each(&block)
  end

  private

  def list
    @list
  end
end
