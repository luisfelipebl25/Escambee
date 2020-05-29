class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :proposal

  validates_presence_of :user, :proposal

  def given
    @given ||= user.answer(proposal).to_give
  end

  def received
    @received ||= user.answer(proposal).to_receive
  end

  def execute
    return false if executed?

    given; received
    user.wishlist.delete(received)
    user.ownlist.delete(given)
    user.ownlist.push received
    user.exchanges.push self
  end

  private

  def executed?
    self.persisted?
  end
end
