require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get addPlayer_path
    assert_response :success
  end
end
