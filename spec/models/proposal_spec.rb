require 'rails_helper'

RSpec.describe Proposal do
  let(:games) { build_list :game, 2 }
  let(:proposal) { create :proposal, games: games }
  let(:user_one) { create :user, owns: [proposal.first_game], wishes: [proposal.second_game] }
  let(:user_two) { create :user, owns: [proposal.second_game], wishes: [proposal.first_game] }

  describe '#answer' do
    context 'Usuário não possui jogo' do
      let(:invalid_user) { create :user, owns: [], wishes: [proposal.second_game] }

      it 'não permite a operação' do
        expect(proposal.answer(invalid_user, true)).to be false
      end
    end

    context 'Usuário não deseja jogo' do
      let(:invalid_user) { create :user, owns: [proposal.first_game], wishes: [] }

      it 'não permite a operação' do
        expect(proposal.answer(invalid_user, true)).to be false
      end
    end

    context 'Usuário tem um jogo e deseja outro' do
      it 'adiciona a resposta no histórico do usuário' do
        expect { proposal.answer(user_one, true) }.to change(user_one.proposal_answers, :count).by(1)
      end

      it 'adciona a resposta nas respostas da proposta' do
        expect { proposal.answer(user_one, true) }.to change(proposal.answers, :count).by(1)
      end
    end

    it 'não pode ser respondida duas vezes pelo mesmo usuário' do
      proposal.answer(user_one, true)

      expect { proposal.answer(user_one, false) }.to_not change(proposal.answers, :count)
    end
  end

  describe '#positive_answers' do
    before(:each) do
      proposal.answer(user_one, true)
      proposal.answer(user_two, false)
    end

    it 'retorna respostas em que o usuário aceitou a proposta' do
      expect(proposal.positive_answers.map(&:user)).to include(user_one)
    end

    it 'não retorna respostas em que o usuário negou a proposta' do
      expect(proposal.positive_answers.map(&:user)).to_not include(user_two)
    end
  end
end
