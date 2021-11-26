require "test_helper"

class RoundTest < ActiveSupport::TestCase
  def setup
    @first_round = rounds(:first_round)
    @player1 = players(:ianiv)
    @player2 = players(:alejandro)
    @first_player1_bet = @player1.bets.build(amount: 600, color: 'Rojo')
    @first_player2_bet = @player2.bets.build(amount: 150, color: 'Negro')
    @first_round.bets << [@first_player1_bet, @first_player2_bet]
  end

  test "round should be valid" do
    assert @first_round.valid?
  end

  test "total number of bets in first_round is 2" do
    total_number_of_bets_in_first_round = @first_round.bets.size
    assert_equal 2, total_number_of_bets_in_first_round
  end

  test "round notifies players the results of the round" do
    assert_equal @first_round.bets.size, 2
    player1_balance_before_bet = @player1.balance
    # assert_equal player1_balance_before_bet, 10000

    @player1.bet(@first_player1_bet)
    player1_balance_after_bet = @player1.balance
    # assert_equal player1_balance_after_bet, 9400

    player2_balance_before_bet = @player2.balance
    # assert_equal player2_balance_before_bet, 10000

    @player2.bet(@first_player2_bet)
    player2_balance_after_bet = @player2.balance
    # assert_equal player2_balance_after_bet, 9850

    @first_round.notify()

    player1_balance_after_round = @player1.balance
    # assert_equal player1_balance_after_round, 10600

    player2_balance_after_round = @player2.balance
    # assert_equal player2_balance_after_round, 9850

    assert_equal player1_balance_after_bet +  2*@first_player1_bet.amount, player1_balance_after_round
    assert_equal player2_balance_after_bet, player2_balance_after_round
  end
end
