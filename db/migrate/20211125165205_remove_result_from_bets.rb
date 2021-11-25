class RemoveResultFromBets < ActiveRecord::Migration[6.1]
  def change
    remove_column :bets, :result, :integer
  end
end
