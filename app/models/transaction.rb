class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :proposal

  validates_presence_of :user, :proposal

  def given
    user.answer(proposal).to_give
  end

  def received
    user.answer(proposal).to_receive
  end

  def execute
    return false if executed?

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
