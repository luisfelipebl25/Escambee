require 'rails_helper'

RSpec.describe GameExchange::Match do
  let(:games) { build_list :game, 2 }
  let(:user) { build :user }
  let(:another_user) { build :user }
  subject { described_class.new games }

  describe '#proposable' do
    context 'dois usuários possuem uma combinação desejo/posse compatível' do
      it 'é possível gerar uma proposta' do
        # user.ownlist.push games.first
        # user.wishlist.push games.second

        # another_user.ownlist.push games.second
        # another_user.wishlist.push games.first

        allow(games.first).to receive(:who_wishes).and_return([user])
        allow(games.first).to receive(:who_owns).and_return([another_user])
        allow(games.second).to receive(:who_wishes).and_return([another_user])
        allow(games.second).to receive(:who_owns).and_return([user])
        
        expect(subject.proposable(games.first, games.second)).to be true
      end
    end
  end
end
