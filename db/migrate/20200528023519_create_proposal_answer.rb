class CreateProposalAnswer < ActiveRecord::Migration[5.1]
  def change
    create_table :proposal_answers do |t|
      t.references :proposal, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :direction
      t.boolean :answer
    end
  end
end
