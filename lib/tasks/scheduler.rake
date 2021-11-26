desc "This task is called by the Heroku scheduler add-on"

task :first_task => :environment do 
    puts "first task working ..."
    puts "done."
end


task :play_roulette => :environment do
  puts "Playing a Roulette round ..."
  if Roulette.first.nil?
    @roulette = Roulette.create
  else
    puts "we already got a Roulette!"
    @roulette = Roulette.first
  end
  @roulette.result = @roulette.get_bet_color
  @roulette.create_round

  players = Player.order("created_at DESC")
  players.each do |player|
    puts player.first_name
    bet_amount = player.get_bet_amount()
    bet_color = player.get_bet_color()
    bet = player.bets.create!(amount: bet_amount, color: bet_color, round: @roulette.get_actual_round)
    player.bet(bet)
  end
  @roulette.notify_results
  puts "done."
end

task add_money_to_each_player: :environment do
    players = Player.order("created_at DESC")
    players.each do |player|
        player_balance = player.balance
        player.update_balance(player_balance + 10000)
    end
  end

  task get_max_temperature_for_next_seven_days: :environment do
    puts "Getting max temperature for next seven days ..."
    if Roulette.first.nil?
      @roulette = Roulette.create
    else
      puts "we already got a Roulette!"
      @roulette = Roulette.first
    end
    @roulette.get_max_forecast_temperature_in_seven_day
  end
 