module Colorable
  extend ActiveSupport::Concern

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
  def _get_color(random_integer)
    if random_integer >= 1 && random_integer <= 49
      "Rojo"
    elsif random_integer >= 50 && random_integer <= 98
      "Negro"
    elsif random_integer >= 99 && random_integer <= 100
      "Verde"
    end
  end
end
