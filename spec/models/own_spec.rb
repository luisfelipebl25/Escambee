require 'rails_helper'

RSpec.describe Own, type: :model do
  let(:user) { create :user }
  let(:game) { build :game }

  describe 'validações' do
    it { expect(build(:own)).to be_valid }

    it 'game_id não pode ficar vazio' do
      expect(build :own, game_id: nil).to_not be_valid
    end

    it 'game_id precisa ser um número' do
      expect(build :own, game_id: 'ASAS' ).to_not be_valid
      expect(build :own, game_id: '1ASAS' ).to_not be_valid
    end
  end

  context 'adicionar um elemento à ownlist' do
    it 'adiciona um elemento de Wish' do
      expect { user.ownlist.push game }.to change(user.owns, :count).by(1)
    end
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
