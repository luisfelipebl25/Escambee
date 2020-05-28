class CreateMatchAnswer < ActiveRecord::Migration[5.1]
  def change
    create_table :match_answers do |t|
      t.references :match, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :answer
    end
  end
end
