

@roulette = Roulette.create
@roulette.result = @roulette.get_bet_color

Player.create!(first_name: "Ianiv",
               last_name: "Hojman",
               email: "ihojmanb@yahoo.com",
               roulette_id: @roulette.id)

5.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "fake_email_#{n + 1}@nnodes.com"

  Player.create!(first_name: first_name,
                 last_name: last_name,
                 email: email,
                 roulette_id: @roulette.id)
end

case Rails.env
when "development"
  5.times do
    @roulette.create_round
    players = Player.order("created_at DESC")
    players.each do |player|
      bet_amount = player.get_bet_amount()
      bet_color = player.get_bet_color()
      player.roulette = @roulette
      bet = player.bets.create!(amount: bet_amount, color: bet_color, round: @roulette.get_actual_round)
      player.bet(bet)
    end
  end
end

