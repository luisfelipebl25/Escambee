require 'rails_helper'

RSpec.describe Gamelist do
  let(:user) { create :user }
  let(:game) { build :game }
  describe 'Wishlist' do
    context 'adicionar um elemento à wishlist' do
      it 'adiciona um elemento de Wish' do
        expect { user.wishlist.push game }.to change(user.wishes, :count).by(1)
      end
    end

    it 'um mesmo jogo não pode ser adicionado duas vezes' do
      user.wishlist.push game

      expect { user.wishlist.push game }.to_not change(user.wishes, :count)
    end

    it 'não pode ser adicionado caso esteja na lista de jogos que possui' do
      user.ownlist.push game

      expect { user.wishlist.push game }.to_not change(user.wishes, :count)
    end

    context 'remover um elemento à wishlist' do
      before(:each) do
        user.wishlist.push game
      end

      it 'remove um elemento de Wish' do
        expect { user.wishlist.delete game }.to change(user.wishes, :count).by(-1)
      end

      it 'remove o desejo da tabela' do
        expect { user.wishlist.delete game }.to change(Wish, :count).by(-1)
      end
    end
  end

  describe 'Ownlist' do
    context 'adicionar um elemento à ownlist' do
      it 'adiciona um elemento de Wish' do
        expect { user.ownlist.push game }.to change(user.owns, :count).by(1)
      end
    end

    it 'um mesmo jogo não pode ser adicionado duas vezes' do
      user.ownlist.push game

      expect { user.ownlist.push game}.to_not change(user.owns, :count)
    end

    it 'não pode ser adicionado caso esteja na lista de desejos' do
      user.wishlist.push game

      expect { user.ownlist.push game}.to_not change(user.owns, :count)
    end

    context 'remover um elemento à ownlist' do
      before(:each) do
        user.ownlist.push game
      end

      it 'remove um elemento de Wish' do
        expect { user.ownlist.delete game }.to change(user.owns, :count).by(-1)
      end

      it 'remove o desejo da tabela' do
        expect { user.ownlist.delete game }.to change(Own, :count).by(-1)
      end
    end
  end
end