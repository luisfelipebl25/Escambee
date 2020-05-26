require 'rails_helper'

RSpec.describe Wish, type: :model do
  let(:user) { create :user }
  let(:game) { build :game }

  context 'adicionar um elemento à wishlist' do
    it 'adiciona um elemento de Wish' do
      expect { user.wishlist.push game }.to change(user.wishes, :count).by(1)
    end
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
