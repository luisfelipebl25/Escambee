require 'rails_helper'

RSpec.describe GameExchange::Exchange do
  let(:games) { build_list :game, 2 }
  let(:proposal) { build :proposal, games: games }
  let(:user_one) { build :user, owns: [proposal.game_one], wishes: [proposal.game_two] }
  let(:user_two) { build :user, owns: [proposal.game_two], wishes: [proposal.game_one] }

  subject { described_class.new(user_one, user_two, proposal) }

  describe '#matched?' do
    context 'Duas partes aceitam' do
      context 'cada usuário quer um jogo diferente' do
        it 'uma troca é possível' do
          proposal.answer(user_one, true)
          proposal.answer(user_two, true)

          expect(subject).to be_matched
        end
      end
      context 'ambos desejam o mesmo jogo' do
        let(:user_two) { user_one.clone }
        it 'uma troca não é possível' do
          proposal.answer(user_one, true)
          proposal.answer(user_two, true)

          expect(subject).to_not be_matched
        end
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

  describe '#exchange' do
    context 'Numa tentativa de troca inválida' do
      context 'Porque uma das partes rejeitou a troca' do
        before(:each) do
          proposal.answer(user_one, true)
          proposal.answer(user_two, false)

          subject.exchange
        end

        it { expect(user_one.wishlist).to_not be_empty }
        it { expect(user_two.wishlist).to_not be_empty }
      end

      context 'Porque uma das partes não respondeu a oferta' do
        before(:each) do
          proposal.answer(user_one, true)

          subject.exchange
        end

        it { expect(user_one.wishlist).to_not be_empty }
        it { expect(user_one.wishlist).to_not be_empty }
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
          expect(user_one.wishlist).to_not include(proposal.game_two)
        end

        it 'não possui mais jogo A' do
          expect(user_one.ownlist).to_not include(proposal.game_one)
        end

        it 'possui jogo B' do
          expect(user_one.ownlist).to include(proposal.game_two)
        end

        describe 'gerou uma transação Usuário 1: Jogo A <-> Jogo B' do
          it 'uma transação foi gerada' do
            expect(user_one.exchanges).to_not be_empty
          end

          it 'que doou jogo A' do
            expect(user_one.exchanges.first.given).to eq(proposal.game_one)
          end

          it 'em troca de jogo B' do
            expect(user_one.exchanges.first.received).to eq(proposal.game_two)
          end
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

        describe 'gerou uma transação Usuário 2: Jogo B <-> Jogo A' do
          it 'uma transação foi gerada' do
            expect(user_two.exchanges).to_not be_empty
          end

          it 'que doou jogo B' do
            expect(user_two.exchanges.first.given).to eq(proposal.game_two)
          end

          it 'em troca de jogo A' do
            expect(user_two.exchanges.first.received).to eq(proposal.game_one)
          end
        end
      end
    end
  end
end
