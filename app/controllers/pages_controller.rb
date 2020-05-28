class PagesController < ApplicationController
  
  def index
  end

  def howitworks

  end  

  def profile
  end  
  
  def search
    search_params
    @games = GiantBomb::Search.new().query(@search).resources('game').fetch
    @results = Kaminari.paginate_array(@games).page(params[:page]).per(8)
  end 

  private
  def search_params
    if params[:search]
      @search = params[:search]
    end
  end
end
