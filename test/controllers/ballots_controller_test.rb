require 'test_helper'

class BallotsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ballots_index_url
    assert_response :success
  end

end
