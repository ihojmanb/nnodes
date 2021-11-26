desc "This task is called by the Heroku scheduler add-on"

task :first_task => :environment do 
    puts "first task working ..."
    puts "done."
end
task :play_roulette => :environment do
  puts "Playing a Roulette round ..."

  puts "done."
end

task :play_roulette_for_real => :environment do
  puts "Playing a Roulette round ..."
  @roulette = Roulette.create
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

task start_my_service: :environment do
    1.upto(9) do |iteration|
      start_time = DateTime.now
      Services::MyService.call
      end_time = DateTime.now
      wait_time = 60 - ((end_time - start_time) * 24 * 60 * 60).to_i
      sleep wait_time if wait_time > 0
    end
  end
