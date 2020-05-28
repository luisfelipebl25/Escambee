class CreateTransaction < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.references :user, foreign_key: true
      t.string :given_game_id
      t.string :received_game_id
    end
  end
end
