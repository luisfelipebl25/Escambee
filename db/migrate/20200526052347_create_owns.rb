class CreateOwns < ActiveRecord::Migration[5.1]
  def change
    create_table :owns do |t|
      t.string :game_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
