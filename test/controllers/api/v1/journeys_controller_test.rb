require "test_helper"

class Api::V1::JourneysControllerTest < ActionDispatch::IntegrationTest
  test "should fail without token" do
    get api_v1_journeys_url
    assert_response :unauthorized
  end

  test "syncs journeys" do
    auth_as(users(:one))

    @journey = journeys(:one)

    post sync_api_v1_journeys_path, as: :json, params: {
      deleted_uuids: [ @journey.uuid ],
      journeys: [ {} ] # If this array is empty, it will be dropped from params and throw ActionController::ParameterMissing, so we have to send a placeholder
    }

    assert_response :success
    assert @journey.reload.soft_deleted?
  end
end
