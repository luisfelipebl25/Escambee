require 'rails_helper'

RSpec.describe Transaction do
  subject { build(:transaction) }

  describe '#execute' do
    describe 'é idempotente' do
      before(:each) { subject.execute }
      it 'não altera a lista de desejos' do
        expect { subject.execute }.to_not change(subject.user, :wishlist)
      end

      it 'não altera os jogos que ele tem' do
        expect { subject.execute }.to_not change(subject.user, :ownlist)
      end

      it 'não se adiciona à lista de transações novamente' do
        expect { subject.execute }.to_not change(subject.user, :wishlist)
      end
    end

    describe 'realiza a troca para um usuário' do
      it 'remove da lista de desejos o jogo recebido' do
        expect { subject.execute }.to change(subject.user.wishlist, :count).by(-1)
      end

      it 'remove o jogo doado dos jogos que possui' do
        subject.execute
        expect(subject.user.ownlist).to_not include(1)
      end

      it 'adiciona o jogo recebido à lista de jogos que possui' do
        subject.execute
        expect(subject.user.ownlist).to include(2)
      end

      it 'adiciona a transação ao final da lista de transações do usuário' do
        subject.execute
        expect(subject.user.exchanges).to include(subject)
      end
    end
  end
end
