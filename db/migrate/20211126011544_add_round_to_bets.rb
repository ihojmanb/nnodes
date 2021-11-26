class AddRoundToBets < ActiveRecord::Migration[6.1]
  def change
    add_reference :bets, :round, foreign_key: true
  end
end
