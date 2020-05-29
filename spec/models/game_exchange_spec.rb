require 'rails_helper'

RSpec.describe 'dois usuários trocam de jogos' do
  describe 'cenário' do
    it 'Troca de jogos - caminho principal' do
      # Jogos adicionados
      games = build_list :game, 2

      # Criação de usuários
      user_one = create :user
      user_two = create :user

      # Usuário 1 adiciona jogos que possui e quer
      user_one.ownlist.push games.first
      user_one.wishlist.push games.second

      # Usuário 2 adiciona jogos que possui e quer
      user_two.ownlist.push games.second
      user_two.wishlist.push games.first

      # Sistema reconhece possíveis Trocas e gera propostas
      match = GameExchange::Matcher.new games
      proposals = match.proposals.each(&:save!)

      # Usuários respondem às propostas
      user_one.proposals(Proposal.all).first.answer(user_one, true)
      user_two.proposals(Proposal.all).first.answer(user_two, true)

      # Geram Matches para trocas aceitas por usuários
      matches = match.generate_matches(proposals).each(&:save!)

      # Usuários confirmam os Matches
      user_one.matches(Match.all).find { |m| m.users.include? user_two }.answer(user_one, true)
      user_two.matches(Match.all).find { |m| m.users.include? user_one }.answer(user_two, true)

      # Sistema reconhece que há um match confirmado
      confirmed_matches = match.confirmed_matches(Match.all)
      confirmed_matches.each do |xmatch|
        # Sistema realiza a troca
        exchange = GameExchange::Exchange.new(xmatch.users.first, xmatch.users.second, xmatch.proposal)
        exchange.exchange if exchange.matched?
      end

      # Fim
      expect(user_one.exchanges.count).to eq(1)
      expect(user_two.exchanges.count).to eq(1)
    end
  end
end
