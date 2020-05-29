require 'rails_helper'

RSpec.describe ProposalAnswer do
  let(:games) { build_list :game, 2 }
  let(:proposal) { create :proposal,  games: games}

  describe 'Validações' do
    it { expect(build :proposal_answer).to be_valid }

    it 'sem usuário é inválido' do
      expect(build :proposal_answer, user: nil).to_not be_valid
    end

    it 'sem proposta é inválido' do
      expect(build :proposal_answer, proposal: nil).to_not be_valid
    end

    it 'resposta diferente de verdadeiro/falso é inválido' do
      expect(build :proposal_answer, answer: nil).to_not be_valid
    end
  end

  subject { create :proposal_answer, games: games, proposal: proposal }
  describe '#accepted?' do
    it 'retorna se o usuário aceitou a proposta' do
      expect(subject.accepted?).to eq(subject.answer)
    end
  end

  describe '#direction' do
    context 'quando o usuário que respondeu foi proposta a trocar jogo A por jogo B' do
      it 'é uma troca direta' do
        expect(subject.direction).to eq("forward")
      end
    end

    context 'quando o usuário que respondeu foi proposto a trocar jogo B por jogo A' do
      subject { create :proposal_answer, :backwards_user }
      it 'é uma troca reversa' do
        expect(subject.direction).to eq("backward")
      end
    end

    context 'quando as lista de jogos do usuário é alterada no meio de uma transação' do
      it 'a direção se mantém a mesma' do
        subject.save!
        expect { subject.user.wishes.destroy_all }.to_not change(subject, :direction)
      end
    end
  end

  context 'troca direta' do
    describe '#to_give' do
      it 'retorna jogo A' do
        expect(subject.to_give).to eq(proposal.first_game)
      end
    end

    describe '#to_receive' do
      it 'retorna jogo B' do
        expect(subject.to_receive).to eq(proposal.second_game)
      end
    end
  end

  describe 'troca inversa' do
    subject { create :proposal_answer, games: games, proposal: proposal, forward: false }
    describe '#to_give' do
      it 'retorna jogo B' do
        expect(subject.to_give).to eq(proposal.second_game)
      end
    end
    describe '#to_receive' do
      it 'retorna jogog A' do
        expect(subject.to_receive).to eq(proposal.first_game)
      end
    end
  end
end
