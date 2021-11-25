class AddColorToBets < ActiveRecord::Migration[6.1]
  def change
    add_column :bets, :color, :string
  end
end
