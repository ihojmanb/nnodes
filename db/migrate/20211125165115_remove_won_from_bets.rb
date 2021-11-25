class RemoveWonFromBets < ActiveRecord::Migration[6.1]
  def change
    remove_column :bets, :won, :boolean
  end
end
