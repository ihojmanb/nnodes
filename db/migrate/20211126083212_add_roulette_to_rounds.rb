class AddRouletteToRounds < ActiveRecord::Migration[6.1]
  def change
    add_reference :rounds, :roulette, foreign_key: true
  end
end
