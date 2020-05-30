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
    Proposal.find(params['proposal_id'])
            .answer(current_user, params['answer'] == 'true')
  end

  def create_game(params)
    @game = Game.new(params) 
  end
end
