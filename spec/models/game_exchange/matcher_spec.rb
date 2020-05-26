require 'rails_helper'

RSpec.describe GameExchange::Matcher do
  let(:games) { build_list :game, 2 }
  let(:user) { build :user }
  let(:another_user) { build :user }
  let(:yet_another_user) { build :user }
  subject { described_class.new games }

  describe '#proposals' do
    context 'quando há dois jogos possiveis de serem trocados por dois usuários' do
      it 'gera uma proposta' do
        user.ownlist.push games.first
        user.wishlist.push games.second

        another_user.ownlist.push games.second
        another_user.wishlist.push games.first

        expect(subject.proposals).to include(Proposal.new(games.first, games.second))
      end
    end
  end

  describe '#proposable' do
    context 'dois usuários possuem uma combinação desejo/posse compatível' do
      it 'é possível gerar uma proposta' do
        user.ownlist.push games.first
        user.wishlist.push games.second

        another_user.ownlist.push games.second
        another_user.wishlist.push games.first

        expect(subject.proposable(games.first, games.second)).to be true
      end
    end
  end

  describe '#has_matches?' do
    before(:each) do
      user.ownlist.push games.first
      user.wishlist.push games.second

      another_user.ownlist.push games.second
      another_user.wishlist.push games.first
    end
    context 'dois usuários aceitam uma troca, sendo um aceitando em cada direção' do
      it 'gera um match' do
        proposals = subject.proposals

        user.proposals(proposals).first.answer(user, true)
        another_user.proposals(proposals).first.answer(another_user, true)

        expect(subject.has_matches?(proposals.first)).to be true
      end
    end

    context 'um usuário aceita e outro rejeita' do
      it 'não gera matches' do
        proposals = subject.proposals

        user.proposals(proposals).first.answer(user, true)
        another_user.proposals(proposals).first.answer(another_user, false)

        expect(subject.has_matches?(proposals.first)).to be true
      end
    end

    context 'dois usuários aceitam uma troca, ambos na mesma direção' do
      it 'não gera um match' do
        yet_another_user.ownlist.push games.first
        yet_another_user.wishlist.push games.second

        proposals = subject.proposals

        user.proposals(proposals).first.answer(user, true)
        yet_another_user.proposals(proposals).first.answer(yet_another_user, true)

        expect(subject.has_matches?(proposals.first)).to be false
      end
    end

    context 'três usuários aceitam uma troca, um com direção diferente dos outros' do
      it 'gera dois matches' do
        yet_another_user.ownlist.push games.first
        yet_another_user.wishlist.push games.second

        proposals = subject.proposals

        user.proposals(proposals).first.answer(user, true)
        another_user.proposals(proposals).first.answer(another_user, true)
        yet_another_user.proposals(proposals).first.answer(yet_another_user, true)

        expect(subject.has_matches?(proposals.first)).to be true
      end
    end
  end

  describe '#generate_matchers' do
    before(:each) do
      user.ownlist.push games.first
      user.wishlist.push games.second

      another_user.ownlist.push games.second
      another_user.wishlist.push games.first
    end

    context 'dois usuários aceitam uma troca, sendo um aceitando em cada direção' do
      it 'gera um match' do
        proposals = subject.proposals

        user.proposals(proposals).first.answer(user, true)
        another_user.proposals(proposals).first.answer(another_user, true)

        expect(subject.generate_matches(proposals).count).to be 1
      end
    end

    context 'um usuário aceita e outro rejeita' do
      it 'não gera matches' do
        proposals = subject.proposals

        user.proposals(proposals).first.answer(user, true)
        another_user.proposals(proposals).first.answer(another_user, false)

        expect(subject.generate_matches(proposals)).to be_empty
      end
    end

    context 'dois usuários aceitam uma troca, ambos na mesma direção' do
      it 'não gera um match' do
        yet_another_user.ownlist.push games.first
        yet_another_user.wishlist.push games.second

        proposals = subject.proposals

        user.proposals(proposals).first.answer(user, true)
        another_user.proposals(proposals).first.answer(another_user, false)
        yet_another_user.proposals(proposals).first.answer(yet_another_user, true)

        expect(subject.generate_matches(proposals)).to be_empty
      end
    end

    context 'três usuários aceitam uma troca, um com direção diferente dos outros' do
      it 'gera dois matches' do
        yet_another_user.ownlist.push games.first
        yet_another_user.wishlist.push games.second

        proposals = subject.proposals

        user.proposals(proposals).first.answer(user, true)
        another_user.proposals(proposals).first.answer(another_user, true)
        yet_another_user.proposals(proposals).first.answer(yet_another_user, true)

        expect(subject.generate_matches(proposals).count).to be 2
      end
    end
  end

  describe '#confirmed_matchs' do
    it 'retorna os matches que foram combinados por ambas as partes' do
      user.ownlist.push games.first
      user.wishlist.push games.second

      another_user.ownlist.push games.second
      another_user.wishlist.push games.first

      proposals = subject.proposals

      user.proposals(proposals).first.answer(user, true)
      another_user.proposals(proposals).first.answer(another_user, true)

      matches = subject.generate_matches(proposals)

      user.matches(matches).first.answer(user, true)
      another_user.matches(matches).first.answer(another_user, true)

      expect(subject.confirmed_matches(matches).count).to eq(1)
    end
  end
end
