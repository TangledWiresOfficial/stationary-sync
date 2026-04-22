require "test_helper"

class Api::V1::JourneysControllerTest < ActionDispatch::IntegrationTest
  test "should fail without token" do
    get api_v1_journeys_url
    assert_response :unauthorized
  end
end
