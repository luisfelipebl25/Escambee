require 'rails_helper'

RSpec.describe User, type: :model do
  let(:games) { build_list :game, 2 }
  let(:proposal) { build :proposal, games: games }
  subject { build :user }

  describe '#proposals' do
    let(:user) { build :user, owns: [games.first], wishes: [games.second] }
    it 'varre as propostas em busca daquelas que o usuário pode aceitar' do
      expect(user.proposals([proposal])).to contain_exactly(proposal)
    end
  end

  describe '#answers' do
    describe 'direction' do
      it 'forward' do
        user = build :user, owns: [games.first], wishes: [games.second]
        proposal.answer(user, true)
        expect(user.proposal_answers.first.direction).to eq(:forward)
      end

      it 'backward' do
        user = build :user, owns: [games.second], wishes: [games.first]
        proposal.answer(user, true)
        expect(user.proposal_answers.first.direction).to eq(:backward)
      end
    end
  end
end
