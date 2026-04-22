require "test_helper"

class Api::V1::StatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_stats_index_url
    assert_response :success
  end
end
