require 'rails_helper'

RSpec.describe Game do
  let(:game) { build :game }
  let(:user) { create :user }

  describe '#who_owns' do
    subject { game.who_owns }
    it 'retorna usuários que possuem o jogo' do
      user.ownlist.push game

      expect(subject).to include(user)
    end

    context 'quando um usuário remover o jogo da lista' do
      it 'o usuário não mais está presente na lista' do
        user.ownlist.push game
        
        expect { user.ownlist.delete game }.to change(subject, :count).by(-1)
      end
    end
  end

  describe '#who_wishes' do
    subject { game.who_wishes }
    it 'retorna usuários que desejam o jogo' do
      user.wishlist.push game

      expect(subject).to include(user)
    end

    context 'quando um usuário remover o jogo da lista' do
      it 'o usuário não mais está presente na lista' do
        user.wishlist.push game
        
        expect { user.wishlist.delete game }.to change(subject, :count).by(-1)
      end
    end
  end
end