require "test_helper"

class Api::V1::JourneysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_journeys_index_url
    assert_response :success
  end
end
