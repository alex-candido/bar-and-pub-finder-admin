# frozen_string_literal: true

require "test_helper"

class Api::V1::PlacesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_places_index_url
    assert_response :success
  end
end
