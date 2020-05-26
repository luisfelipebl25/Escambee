class Transaction
  attr_accessor :user, :given, :received

  def initialize(user, given, received)
    @user = user
    @given = given
    @received = received
    @executed = false
  end

  def execute
    return false if executed?
    @user.wishlist.delete(@received)
    @user.ownlist.delete(@given)
    @user.ownlist.push @received
    @user.exchanges.push self
    @executed = true
  end

  private

  def executed?
    @executed
  end
end
