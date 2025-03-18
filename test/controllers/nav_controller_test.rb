require "test_helper"

class NavControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get nav_index_url
    assert_response :success
  end
end
