class AddActualRoundIdToRoulette < ActiveRecord::Migration[6.1]
  def change
    add_column :roulettes, :actual_round_id, :Integer
  end
end
