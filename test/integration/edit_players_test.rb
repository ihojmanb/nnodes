require "test_helper"

class EditPlayersTest < ActionDispatch::IntegrationTest
  def setup
    @roulette = Roulette.create
    @player = players(:ianiv)
    @player.roulette_id = @roulette.id
  end

  test "invalid player edition" do
    get edit_player_path(@player)
    assert_template 'players/edit'
    patch player_path(@player), params: { player: {
      first_name: "aName",
      last_name: "aLastName",
      email: "invalid@email",
      balance: 14000,
      roulette_id: @roulette.id
    }}
    assert_template 'players/edit'
  end

  # test "valid player edition" do
  #   get edit_player_path(@player)
  #   first_name = "Ricardo"
  #   last_name = "Arjona"
  #   email =  "ricky@arj.com"
  #   balance = 126800
  #   assert_template 'players/edit'
  #   patch player_path(@player), params: { player: {
  #     first_name: first_name,
  #     last_name: last_name,
  #     email: email,
  #     balance: balance,
  #   }}
  #   assert flash.empty?
  #   assert_redirected_to @player
  #   @player.reload
  #   assert_equal first_name, @player.first_name
  #   assert_equal last_name, @player.last_name
  #   assert_equal email, @player.email
  #   assert_equal balance, @player.balance
  # end
end
