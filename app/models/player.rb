class Player < ApplicationRecord
  include Colorable
  require 'rest-client'
  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_many :bets
  belongs_to :roulette


  def get_bet_amount
    if balance <= 1000 && balance >= 0
      balance
    else
      max_temperature = roulette.get_max_forecast_temperature_in_seven_day
      if max_temperature > 29
        amount_percentage = rand(0.03..0.07).round(2)
        amount = Integer(balance * amount_percentage)
        amount
      else
        amount_percentage = rand(0.08..0.15).round(2)
        amount = Integer(balance * amount_percentage)
        amount
      end

    end
  end

  def bet(bet)
    update_balance(balance - bet.amount)
  end

  def check_bet_results(result, bet)
    new_balance = 0
    if result == bet.color
      if result == "Verde"
        new_balance = balance + bet.amount * 15
      else
        new_balance = balance + bet.amount * 2
      end
    else
      new_balance = balance
    end
    update_balance(new_balance)
  end

  def update_balance(new_balance)
    update(balance: new_balance)
  end

  private

  def downcase_email
    email.downcase!
  end
end
