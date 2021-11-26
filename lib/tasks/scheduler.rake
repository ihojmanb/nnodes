desc "This task is called by the Heroku scheduler add-on"

task :play_roulette => :environment do
  puts "Playing a Roulette round ..."
#   @roulette = Roulette.create
#   @roulette.result = @roulette.get_bet_color
#   @roulette.create_round

#   players = Player.order("created_at DESC")
#   players.each do |player|
#     puts player.first_name
    # bet_amount = player.get_bet_amount()
    # bet_color = player.get_bet_color()
    # # bet = player.bets.create!(amount: bet_amount, color: bet_color, round: @roulette.get_actual_round)
    # player.bet(bet)
#   end

#   @roulette.notify_results
  puts "done."
end
