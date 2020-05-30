class CreateMatch < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.references :proposal
      t.integer :forward_user_id
      t.integer :backward_user_id
    end
    add_foreign_key :matches, :users, column: :forward_user_id
    add_foreign_key :matches, :users, column: :backward_user_id
  end
end
