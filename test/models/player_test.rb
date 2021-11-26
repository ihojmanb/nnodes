require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  def setup
    @player = players(:ianiv)
    @first_bet = bets(:first_ianiv_bet)
    @second_bet = bets(:second_ianiv_bet)
    @third_bet = bets(:third_ianiv_bet)
    @player.bets << [@first_bet, @second_bet, @third_bet]
    
  end

  test "should be vaild" do
    assert @player.valid?
  end

  test "first_name should be present" do
    @player.first_name = "    "
    assert_not @player.valid?
  end

  test "last_name should be present" do
    @player.last_name = "    "
    assert_not @player.valid?
  end

  test "email should be present" do
    @player.email = "    "
    assert_not @player.valid?
  end

  test "first_name should not be to long" do
    @player.first_name = "a" * 51
    assert_not @player.valid?
  end

  test "last_name should should not be to long" do
    @player.last_name = "a" * 100
    assert_not @player.valid?
  end

  test "email should should not be to long" do
    @player.email = "a" * 255 + "@example.com"
    assert_not @player.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @player.email = valid_address
      assert @player.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @player.email = invalid_address
      assert_not @player.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_player = @player.dup
    @player.save 
    assert_not duplicate_player.valid?
  end

  test "player bets percentage of balance" do 
    @player.balance = 5000
    bet_amount = @player.get_bet_amount()
    assert bet_amount.is_a? Integer
    assert bet_amount >= 0.08 * @player.balance
    assert bet_amount <= 0.15 * @player.balance
  end

  test "player bets All-in" do 
    @player.balance = 500
    bet_amount = @player.get_bet_amount()
    assert bet_amount.is_a? Integer
    assert_equal bet_amount, @player.balance
  end

  test "get_random_integer returns number between 1 and 100" do 
    random_integer = @player.get_random_integer(1, 100)
    assert random_integer.is_a? Integer
    assert random_integer >= 1
    assert random_integer <= 100
  end

  test "get_random_integer returns number between 1 and 49" do 
    random_integer = @player.get_random_integer(1, 49)
    assert random_integer.is_a? Integer
    assert random_integer >= 1
    assert random_integer <= 49
  end
  test "get_random_integer returns number between 50 and 98" do 
    random_integer = @player.get_random_integer(50, 98)
    assert random_integer.is_a? Integer
    assert random_integer >= 50
    assert random_integer <= 98
  end

  test "get_random_integer returns number between 99 and 100" do 
    random_integer = @player.get_random_integer(99, 100)
    assert random_integer.is_a? Integer
    assert random_integer >= 99
    assert random_integer <= 100
  end

  test " get_color returns Rojo  with 49% of chances" do
    random_integer_between_1_and_49 = @player.get_random_integer(1, 49)
    bet_color = @player.get_color(random_integer_between_1_and_49)
    assert_equal 'Rojo', bet_color
  end
  test " get_color returns Negro  with 49% of chances " do 
    random_integer_between_50_and_98 = @player.get_random_integer(50, 98)
    bet_color = @player.get_color(random_integer_between_50_and_98)
    assert_equal 'Negro', bet_color
  end
  test " get_color returns Verde with 2% of chances" do
    random_integer_between_99_and_100 = @player.get_random_integer(99, 100)
    assert random_integer_between_99_and_100 >= 99
    assert random_integer_between_99_and_100 <= 100
    bet_color = @player.get_color(random_integer_between_99_and_100)
    assert_equal 'Verde', bet_color 
  end

  test "get_bet_color returns Rojo, Negro, or Verde" do 
    bet_color = @player.get_bet_color
    allowed_colors = ['Rojo', 'Negro', 'Verde']
    assert allowed_colors.include? bet_color
  end

  test "bet method discounts bet.amount from player.balance" do 
    @player_balance_before_bet = @player.balance
    @player.bet(@first_bet)
    @player_balance_after_bet = @player.balance
    assert @player_balance_after_bet <= @player_balance_before_bet
  end
  
  test "update_balance when player wins Rojo" do
    bet_amount = @first_bet.amount
    @player.bet(@first_bet)
    player_balance_after_bet = @player.balance
    @player.check_bet_results('Rojo', @first_bet)
    player_balance_after_round = @player.balance
    assert_equal player_balance_after_bet + 2*bet_amount, player_balance_after_round
  end

  test "update_balance when player wins Negro" do
    bet_amount = @second_bet.amount
    @player.bet(@second_bet)
    player_balance_after_bet = @player.balance
    @player.check_bet_results('Negro', @second_bet)
    player_balance_after_round = @player.balance
    assert_equal player_balance_after_bet + 2*bet_amount, player_balance_after_round
  end

  test "update_balance when player wins Verde" do
    bet_amount = @third_bet.amount
    @player.bet(@third_bet)
    player_balance_after_bet = @player.balance
    @player.check_bet_results('Verde', @third_bet)
    player_balance_after_round = @player.balance
    assert_equal player_balance_after_bet + 15*bet_amount, player_balance_after_round
  end

  test "update_balance when player loses" do
  end

end
