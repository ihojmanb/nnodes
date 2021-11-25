class CreateBets < ActiveRecord::Migration[6.1]
  def change
    create_table :bets do |t|
      t.integer :amount
      t.boolean :won
      t.integer :result
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
    add_index :bets, [:player_id, :created_at]
  end
end
