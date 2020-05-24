require 'rails_helper'

RSpec.describe GameExchange::Match do
  let(:games) { build_list :game, 2 }
  let(:user) { build :user }
  let(:another_user) { build :user }
  subject { described_class.new games }

  describe '#proposals' do
    context 'quando há dois jogos possiveis de serem trocados por dois usuários' do
      it 'gera uma proposta' do
        user.ownlist.push games.first
        user.wishlist.push games.second

        another_user.ownlist.push games.second
        another_user.wishlist.push games.first

        expect(subject.proposals).to include(Proposal.new games.first, games.second)
      end
    end
  end

  describe '#proposable' do
    context 'dois usuários possuem uma combinação desejo/posse compatível' do
      it 'é possível gerar uma proposta' do
        user.ownlist.push games.first
        user.wishlist.push games.second

        another_user.ownlist.push games.second
        another_user.wishlist.push games.first

        expect(subject.proposable(games.first, games.second)).to be true
      end
    end
  end
end
