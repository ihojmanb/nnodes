require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  def setup
    @player = Player.new(first_name: "Ex", last_name: "Ample", email: "player@example.com")
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






end
