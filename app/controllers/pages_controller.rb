class PagesController < ApplicationController
  
  def index
    @games = GiantBomb::Game.list.shuffle
    paginate(@games, 12)
  end
  
  def paginate(games, n_games)
    @results = Kaminari.paginate_array(games).page(params[:page]).per(n_games)   
  end 

  def profile
  end  
  
  def search
    search_params
    @games = GiantBomb::Search.new().query(@search).resources('game').fetch
    paginate(@games, 8)
  end 

  private
  def search_params
    if params[:search]
      @search = params[:search]
    end
  end
end
