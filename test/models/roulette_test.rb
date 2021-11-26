require "test_helper"

class RouletteTest < ActiveSupport::TestCase
  def setup
    @roulette = Roulette.create
    @roulette.result = 'Rojo'
    @roulette.create_round
    # @roulette.rounds << [rounds(:first_round), rounds(:second_round), rounds(:third_round)]
    @player1 = players(:ianiv)
    @player2 = players(:alejandro)
    @first_player1_bet = @player1.bets.build(amount: 600, color: "Rojo")
    @first_player2_bet = @player2.bets.build(amount: 800, color: "Rojo")
    # @third_player1_bet = @player1.bets.build(amount: 30, color: "Verde")
    @roulette.rounds.first.bets << [@first_player1_bet, @first_player2_bet]
    # @roulette.rounds.second.bets << @second_player1_bet
    # @roulette.rounds.third.bets << @third_player1_bet
  end

  test "roulette is valid" do
    assert @roulette.valid?
  end

  test "roulette rounds have bets" do
    assert @roulette.rounds.first.bets.size > 0
    # assert @roulette.rounds.second.bets.size > 0
    # assert @roulette.rounds.third.bets.size > 0
  end
  test "get_random_integer returns number between 1 and 100" do
    random_integer = @roulette.get_random_integer(1, 100)
    assert random_integer.is_a? Integer
    assert random_integer >= 1
    assert random_integer <= 100
  end

  test "get_random_integer returns number between 1 and 49" do
    random_integer = @roulette.get_random_integer(1, 49)
    assert random_integer.is_a? Integer
    assert random_integer >= 1
    assert random_integer <= 49
  end
  test "get_random_integer returns number between 50 and 98" do
    random_integer = @roulette.get_random_integer(50, 98)
    assert random_integer.is_a? Integer
    assert random_integer >= 50
    assert random_integer <= 98
  end

  test "get_random_integer returns number between 99 and 100" do
    random_integer = @roulette.get_random_integer(99, 100)
    assert random_integer.is_a? Integer
    assert random_integer >= 99
    assert random_integer <= 100
  end

  test " get_color returns Rojo  with 49% of chances" do
    random_integer_between_1_and_49 = @roulette.get_random_integer(1, 49)
    bet_color = @roulette.get_color(random_integer_between_1_and_49)
    assert_equal "Rojo", bet_color
  end
  test " get_color returns Negro  with 49% of chances " do
    random_integer_between_50_and_98 = @roulette.get_random_integer(50, 98)
    bet_color = @roulette.get_color(random_integer_between_50_and_98)
    assert_equal "Negro", bet_color
  end
  test " get_color returns Verde with 2% of chances" do
    random_integer_between_99_and_100 = @roulette.get_random_integer(99, 100)
    assert random_integer_between_99_and_100 >= 99
    assert random_integer_between_99_and_100 <= 100
    bet_color = @roulette.get_color(random_integer_between_99_and_100)
    assert_equal "Verde", bet_color
  end

  test "get_roulette_result returns Rojo, Negro, or Verde" do
    roulette_result = @roulette.get_bet_color
    allowed_results = ["Rojo", "Negro", "Verde"]
    assert allowed_results.include? roulette_result
  end

  test "roulette sets color to round" do 
    roulette_result = @roulette.get_bet_color
    @roulette.set_color_to_actual_round(roulette_result)
    actual_round = @roulette.get_actual_round
    assert_equal roulette_result, actual_round.color
  end

  test "roulette creates new round" do
    past_round = @roulette.get_actual_round 
    @roulette = Roulette.create
    @roulette.result = @roulette.get_bet_color
    @roulette.create_round
    assert_not past_round == @roulette.get_actual_round 
  end

  test "roulette notify results" do 
    player1_balance_before_notification = @player1.balance
    player2_balance_before_notification = @player2.balance
    @roulette.notify_results
    player1_balance_after_notification = @player1.balance
    player2_balance_after_notification = @player2.balance

    assert player1_balance_after_notification >= player1_balance_before_notification
    assert player2_balance_after_notification >= player2_balance_before_notification
  end


end
