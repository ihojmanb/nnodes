require "test_helper"

class BetTest < ActiveSupport::TestCase
  def setup
    @player = players(:ianiv)
    @bet = @player.bets.build(amount:150)
  end

  test "bet should be valid" do 
    assert @bet.valid?
  end

  test "player id should be present" do 
    @bet.player_id = nil
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

  test "order should be most recent first" do 
    assert_equal bets(:most_recent), Bet.first
  end


end
