class Transaction
  attr_accessor :user, :given, :received

  def initialize(user, given, received)
    @user = user
    @given = given
    @received = received
  end

  def execute
    @user.wishlist.delete(@received)
    @user.ownlist.delete(@given)
    @user.ownlist.push @received
    @user.exchanges.push self
  end
end
