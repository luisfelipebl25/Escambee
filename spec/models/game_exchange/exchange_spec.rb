require 'rails_helper'

RSpec.describe GameExchange::Exchange do
  let(:proposal) { build :proposal }
  let(:user_one) { build :user, ownlist: [proposal.game_one], wishlist: [proposal.game_two] }
  let(:user_two) { build :user, ownlist: [proposal.game_two], wishlist: [proposal.game_one] }
  
  subject { described_class.new(user_one, user_two, proposal) }

  context 'Duas partes aceitam' do
    it 'uma troca é possível' do
      proposal.answer(user_one, true)
      proposal.answer(user_two, true)

      expect(subject).to be_matched
    end
  end

  context 'Apenas uma das partes aceitam' do
    it 'uma troca não é possível' do
      proposal.answer(user_one, true)
      proposal.answer(user_two, false)

      expect(subject).to_not be_matched
    end
  end
end
