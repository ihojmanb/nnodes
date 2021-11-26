class Roulette < ApplicationRecord
  include Colorable
  has_many :rounds

  def create_round
    new_round = rounds.create!(color: get_bet_color)
    update_actual_round_id(new_round.id)
  end

  def set_color_to_actual_round(color)
    actual_round = get_actual_round
    actual_round.update_color(color)
  end

  def get_actual_round
    Round.find(actual_round_id)
  end

  def update_actual_round_id(new_round_id)
    update(actual_round_id: new_round_id)
  end

  def notify_results
    actual_round = get_actual_round
    actual_round.notify
  end



end
