require 'rails_helper'

RSpec.describe 'dois usuários trocam de jogos' do
  describe 'cenário' do
    it 'x' do
      # Jogos adicionados
      games = build_list :game, 2

      # Criação de usuários
      user_one = build :user
      user_two = build :user

      # Usuário 1 adiciona jogos que possui e quer
      user_one.ownlist.push games.first
      user_one.wishlist.push games.second

      # Usuário 2 adiciona jogos que possui e quer
      user_two.ownlist.push games.second
      user_two.wishlist.push games.first

      # Sistema reconhece possíveis Trocas e gera propostas
      match = GameExchange::Match.new games
      proposals = match.proposals

      # Usuários respondem às propostas
      user_one.proposals(proposals).first.answer(user_one, true)
      user_two.proposals(proposals).first.answer(user_two, true)

      # Geram Matches para trocas aceitas por usuários

      # Usuários confirmam os Matches

      # A troca ocorre
      exchange = GameExchange::Exchange.new(user_one, user_two, proposals.first)
      exchange.exchange if exchange.matched?

      # Fim
      expect(user_one.exchanges.count).to eq(1)
      expect(user_two.exchanges.count).to eq(1)
    end
  end
end