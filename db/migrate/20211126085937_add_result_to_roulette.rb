class AddResultToRoulette < ActiveRecord::Migration[6.1]
  def change
    add_column :roulettes, :result, :string
  end
end
