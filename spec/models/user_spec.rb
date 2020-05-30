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

  describe '#can_add_in_list?' do
    let(:game) { build :game }
    context 'quando o jogo não está na lista de desejos ou de jogos que possui' do
      it 'retorna true' do
        expect(subject.can_add_in_list?(game)).to be true
      end
    end

    context 'quando o jogo está na lista de desejos' do
      it 'retorna false' do
        subject.wishlist.push game
        expect(subject.can_add_in_list?(game)).to be false
      end
    end

    context 'quando o jogo está na lista de jogos que possui' do
      it 'retorna false' do
        subject.ownlist.push game
        expect(subject.can_add_in_list?(game)).to be false
      end
    end
  end

  describe '#proposals' do
    let(:user) { create :user, owns: [games.first], wishes: [games.second] }
    it 'varre as propostas em busca daquelas que o usuário pode aceitar' do
      expect(user.proposals([proposal])).to contain_exactly(proposal)
    end

    context 'quando o usuário remove um dos elementos da lista de desejos' do
      it 'não retorna mais nenhuma proposta que envolve receber tal jogo' do
        user.wishlist.delete(games.second)

        expect(user.proposals([proposal])).to be_empty
      end
    end

    context 'quando o usuário remove um dos elementos da lista de jogos que possui' do
      it 'não retorna mais nenhuma proposta que envolve trocar tal jogo' do
        user.ownlist.delete(games.first)

        expect(user.proposals([proposal])).to be_empty
      end
    end
  end

  describe '#pending_proposals' do
    let(:user) { create :user, owns: [games.first], wishes: [games.second] }

    it 'retorna propostas que o usuário não respondeu ainda' do
      expect(user.pending_proposals([proposal])).to include(proposal)
    end

    it 'retorna propostas que o usuário não respondeu que sim' do
      proposal.answer(user, true)

      expect(user.pending_proposals([proposal])).to be_empty
    end

    it 'retorna propostas que o usuário não respondeu que não' do
      proposal.answer(user, false)

      expect(user.pending_proposals([proposal])).to be_empty
    end
  end

  describe '#answers' do
    describe 'direction' do
      it 'forward' do
        user = create :user, owns: [games.first], wishes: [games.second]
        proposal.answer(user, true)
        expect(user.proposal_answers.first.direction.to_sym).to eq(:forward)
      end

      it 'backward' do
        user = create :user, owns: [games.second], wishes: [games.first]
        proposal.answer(user, true)
        expect(user.proposal_answers.first.direction.to_sym).to eq(:backward)
      end
    end
  end
end
