class Bet < ApplicationRecord
  belongs_to :player
  belongs_to :round
  default_scope -> { order(created_at: :desc) }
  validates :player_id, presence: true
  validates :round_id, presence: true
  validates :amount, presence: true, numericality: { only_integer: true}
  validates :color, presence: true, inclusion: {in: %w(Rojo Verde Negro)}

  def notify_player(round)
    result = round.color
    player.check_bet_results(result, self)
  end


end
