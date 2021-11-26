class Roulette < ApplicationRecord
  include Colorable
  require 'rest-client'
  has_many :rounds
  has_many :players

  def get_weather_forecast
    weather_key = ENV["WEATHER_KEY"]
    lat =-33.45 
    lon =-70.66
    url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{lon}&exclude=current,minutely,hourly,alerts&units=metric&lang=es&appid=#{weather_key}"
    response = RestClient.get(url)
    data = JSON.parse(response.body)
    seven_days_forecast_data = data['daily']
    seven_days_forecast_temperature = seven_days_forecast_data.map{|day| day["temp"]["max"]}
  end

  def get_max_forecast_temperature_in_seven_day
    forecast_temperature = get_weather_forecast
    update(temperature: forecast_temperature.max)
    temperature
  end

  def create_round
    new_round = rounds.create!(color: get_bet_color)
    # update_actual_round_id(new_round.id)
    update(actual_round_id: new_round.id)
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
