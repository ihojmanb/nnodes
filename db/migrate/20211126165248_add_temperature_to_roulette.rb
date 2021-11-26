class AddTemperatureToRoulette < ActiveRecord::Migration[6.1]
  def change
    add_column :roulettes, :temperature, :float
  end
end
