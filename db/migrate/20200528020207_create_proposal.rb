class CreateProposal < ActiveRecord::Migration[5.1]
  def change
    create_table :proposals do |t|
      t.string :first_game_id
      t.string :second_game_id
    end
  end
end
