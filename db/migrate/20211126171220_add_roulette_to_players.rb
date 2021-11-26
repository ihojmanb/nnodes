class AddRouletteToPlayers < ActiveRecord::Migration[6.1]
  def change
    add_reference :players, :roulette, foreign_key: true
  end
end
