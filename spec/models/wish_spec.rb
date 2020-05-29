require 'rails_helper'

RSpec.describe Wish, type: :model do
  describe 'validações' do
    it { expect(build(:wish)).to be_valid }

    it 'game_id não pode ficar vazio' do
      expect(build :wish, game_id: nil).to_not be_valid
    end

    it 'game_id precisa ser um número' do
      expect(build :wish, game_id: 'ASAS' ).to_not be_valid
    end
  end
end
