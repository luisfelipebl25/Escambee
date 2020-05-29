class UsersController < ApplicationController
  before_action do
    create_game(params['id'])
  end

  def add_to_wishlist
    current_user.wishlist.push @game
  end 

  def remove_from_wishlist
    current_user.wishlist.delete @game
  end 

  def add_to_ownlist
    current_user.ownlist.push @game
  end 

  def remove_from_ownlist
    current_user.ownlist.delete @game
  end

  def answer_proposal
    # params['answer'] == true ? proposal.answer(current_user, true) : proposal.answer(current_user, false)
    if params['answer']
      current_user.proposals(Proposal.all).answer(current_user, true)
    else 
      current_user.proposals(Proposal.all).answer(current_user, false)
    end 
  end 

  def create_game(params)
    @game = Game.new(params) 
  end 
end 