# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Player.create!(first_name: "Ianiv",
               last_name: "Hojman",
               email: "ihojmanb@yahoo.com")

5.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "fake_email_#{n + 1}@nnodes.com"

  Player.create!(first_name: first_name,
                 last_name: last_name,
                 email: email)
end
case Rails.env
when "development"
  5.times do
    @roulette = Roulette.create
    @roulette.result = @roulette.get_bet_color
    @roulette.create_round
    players = Player.order("created_at DESC")
    players.each do |player|
      bet_amount = player.get_bet_amount()
      bet_color = player.get_bet_color()
      bet = player.bets.create!(amount: bet_amount, color: bet_color, round: @roulette.get_actual_round)
      player.bet(bet)
    end
  end
end
# @roulette = Roulette.create
# @roulette.result = @roulette.get_bet_color
# @roulette.create_round
# # @round = Round.create!(color: 'Rojo')

# # @roulette.actual_round = @round

# players = Player.order('created_at DESC')
# players.each do |player|
#   bet_amount = player.get_bet_amount()
#   bet_color = player.get_bet_color()
#   bet = player.bets.create!(amount: bet_amount, color: bet_color, round: @roulette.get_actual_round)
#   player.bet(bet)
# end

# @roulette.notify_results
# players = Player.order(:created_at).take(5)
# 25.times do
#     players.each do |player|
#         bet_amount = player.get_bet_amount()
#         bet_color = player.get_bet_color()
#         player.bets.create!(amount:bet_amount, color: bet_color)
#     end
# end
