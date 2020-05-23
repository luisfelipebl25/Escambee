require 'rails_helper'

RSpec.describe GameExchange::Exchange do
  let(:proposal) { build :proposal }
  let(:user_one) { build :user, ownlist: [proposal.game_one], wishlist: [proposal.game_two] }
  let(:user_two) { build :user, ownlist: [proposal.game_two], wishlist: [proposal.game_one] }

  subject { described_class.new(user_one, user_two, proposal) }

  context 'Usuário não possui jogo' do
    let(:invalid_user) { build :user, ownlist: [], wishlist: [proposal.game_two] }

    it 'não permite a operação' do
      expect(proposal.answer(invalid_user, true)).to be false
    end
  end

  context 'Usuário não deseja jogo' do
    let(:invalid_user) { build :user, ownlist: [proposal.game_one], wishlist: [] }

    it 'não permite a operação' do
      expect(proposal.answer(invalid_user, true)).to be false
    end
  end

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

  context 'Numa troca bem-sucedida' do
    before(:each) do
      proposal.answer(user_one, true)
      proposal.answer(user_two, true)

      subject.exchange
    end

    describe 'Usuário 1' do
      it 'não deseja mais jogo B' do
        expect(user_one.wishlist).to_not include(proposal.game_one)
      end

      it 'não possui mais jogo A' do
        expect(user_one.ownlist).to_not include(proposal.game_one)
      end

      it 'possui jogo B' do
        expect(user_one.ownlist).to include(proposal.game_two)
      end
    end

    describe 'Usuário 2' do
      it 'não deseja mais jogo A' do
        expect(user_two.wishlist).to_not include(proposal.game_one)
      end

      it 'não possui mais jogo B' do
        expect(user_two.ownlist).to_not include(proposal.game_two)
      end

      it 'possui jogo A' do
        expect(user_two.ownlist).to include(proposal.game_one)
      end
    end
  end
end
