class ChangeColumnsInTransaction < ActiveRecord::Migration[5.1]
  def change
    change_table(:transactions) do |t|
      t.references :proposal, foreign_key: true

      t.remove :given_game_id
      t.remove :received_game_id
    end
  end
end
