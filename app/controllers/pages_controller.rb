class PagesController < ApplicationController
  def index
    @games = GiantBomb::Game.list.shuffle
    paginate(@games, 12)
  end

  def paginate(games, n_games)
    @results = Kaminari.paginate_array(games).page(params[:page]).per(n_games)
  end

  def profile
    match = GameExchange::Matcher.new current_user.gamelist
    match.proposals.each(&:save!)
    @proposals = current_user.proposals(Proposal.all)
  end

  def collection
    @wishes = current_user.wishes
    @owns = current_user.owns
  end 
  
  def search
    @games = GiantBomb::Search.new.query(search_params).resources('game').fetch
    paginate(@games, 8)
  end

  def find_game(id)
    GiantBomb::Game.detail(id)
  end

  private

  def search_params
    params[:search]
  end
end
