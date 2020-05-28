require 'rails_helper'

RSpec.describe User, type: :model do
  let(:games) { build_list :game, 2 }
  let(:proposal) { build :proposal, games: games }
  subject { create :user }

  describe 'validações' do
    it { expect(create :user).to be_valid }

    it 'sem e-mail é inválido' do
      expect(build :user, email: nil).to_not be_valid
    end

    it 'e-mail inválido é inválido' do
      expect(build :user, email: 'Anything').to_not be_valid
    end

    it 'sem senha é inválido' do
      expect(build :user, password: nil, password_confirmation: nil).to_not be_valid
    end

    it 'confirmação diferente da senha é inválido' do
      expect(build :user, password: '12345678', password_confirmation: 'abcdefgh').to_not be_valid
    end
  end

  describe '#proposals' do
    let(:user) { create :user, owns: [games.first], wishes: [games.second] }
    it 'varre as propostas em busca daquelas que o usuário pode aceitar' do
      expect(user.proposals([proposal])).to contain_exactly(proposal)
    end
  end

  describe '#answers' do
    describe 'direction' do
      it 'forward' do
        user = create :user, owns: [games.first], wishes: [games.second]
        proposal.answer(user, true)
        expect(user.proposal_answers.first.direction).to eq(:forward)
      end

      it 'backward' do
        user = create :user, owns: [games.second], wishes: [games.first]
        proposal.answer(user, true)
        expect(user.proposal_answers.first.direction).to eq(:backward)
      end
    end
  end
end
