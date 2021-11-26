require "test_helper"

class BetTest < ActiveSupport::TestCase
  def setup
    @player = players(:ianiv)
    @first_round = rounds(:first_round)
    @bet = @player.bets.build(amount:150, color:'Rojo')
    @bet.round = @first_round
  end

  test "bet should be valid" do 
    assert @bet.valid?
  end

  test "player id should be present" do 
    @bet.player_id = nil
    assert_not @bet.valid?
  end
  
  test "round id should be present" do 
    @bet.round_id = nil
    assert_not @bet.valid?
  end

  test "amount should be present" do 
    @bet.amount = nil
    assert_not @bet.valid?
  end

  test "amount should be integer" do 
    @bet.amount = 'nuevo amount'
    assert_not @bet.valid?
  end

  test "color should be present" do 
    @bet.color = nil
    assert_not @bet.valid?
  end

  test "color should be string" do
    @bet.color = 10
    assert_not @bet.valid?
  end

  test "color should be of a certain value" do 
    @bet.color = 'Azul'
    assert_not @bet.valid?
  end

  test "order should be most recent first" do 
    assert_equal bets(:most_recent), Bet.first
  end

  test "bet notifies player about round results" do
    player_balance_before_bet = @player.balance
    @bet.notify_player(@first_round)
    player_balance_after_bet = @player.balance
    assert_equal player_balance_before_bet + 2*@bet.amount, player_balance_after_bet
  end

end
