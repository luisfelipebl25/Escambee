require 'rails_helper'

RSpec.describe Proposal do
  let(:games) { build_list :game, 2 }
  let(:proposal) { build :proposal, games: games }
  let(:user_one) { build :user, owns: [proposal.game_one], wishes: [proposal.game_two] }
  let(:user_two) { build :user, owns: [proposal.game_two], wishes: [proposal.game_one] }

  describe '#answer' do
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
  end
end
