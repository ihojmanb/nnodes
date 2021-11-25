class Bet < ApplicationRecord
  belongs_to :player
  default_scope -> { order(created_at: :desc) }
  validates :player_id, presence: true
  validates :amount, presence: true, numericality: { only_integer: true}
end
