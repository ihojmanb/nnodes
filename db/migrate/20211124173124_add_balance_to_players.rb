class AddBalanceToPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :balance, :integer, :default=>10000
  end
end
