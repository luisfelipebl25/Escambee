class Transaction
  attr_accessor :user, :given, :received

  def initialize(user, given, received)
    @user = user
    @given = given
    @received = received
  end
end
