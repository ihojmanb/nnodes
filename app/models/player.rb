class Player < ApplicationRecord
  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_many :bets

  def get_bet_amount
    if balance <= 1000 && balance >= 0
      balance      
    else
      amount_percentage = rand(0.08..0.15).round(2)
      amount = Integer(balance * amount_percentage)
      amount
    end

  end

  def get_random_integer(lower_bound, upper_bound)
    rand(lower_bound..upper_bound)
  end

  def get_bet_color
    get_color(get_random_integer(1, 100))
  end

  def get_color(random_integer)
    if random_integer > 100 || random_integer < 1
      raise "integer out of bound [1, 100]"
    else
      _get_color(random_integer)
    end
  end


  private
    def downcase_email
        email.downcase!
    end

    def _get_color(random_integer)
      if random_integer >= 1 && random_integer <= 49
        'Rojo'
      elsif random_integer >= 50 && random_integer <= 98
        'Negro'
      elsif  random_integer >= 99 && random_integer <= 100
        'Verde'
      end
    end
end
