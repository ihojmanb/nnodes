require "test_helper"

require 'test_helper'
class AddPlayersTest < ActionDispatch::IntegrationTest
  
  test "invalid player submission" do
    get addPlayer_path
    assert_no_difference 'Player.count' do
      post players_path, params: { player: {
        first_name: "",
        last_name: "",
        email: "invalid@email"
      }}
    end
    assert_template 'players/new'
  end

  test "valid player submission" do 
    get addPlayer_path
    assert_difference 'Player.count', 1 do
      post players_path, params: { player: {
        first_name: "Ricardo",
        last_name: "Lagos",
        email: "valid@email.com"
      }}
    end
    follow_redirect!
    assert_template 'players/show'
  end

end
