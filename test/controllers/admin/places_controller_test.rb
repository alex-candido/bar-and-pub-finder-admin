# frozen_string_literal: true

require "test_helper"

class Admin::PlacesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_place = admin_places(:one)
  end

  test "should get index" do
    get admin_places_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_place_url
    assert_response :success
  end

  test "should create admin_place" do
    assert_difference("Admin::Place.count") do
      post admin_places_url, params: { admin_place: { coords: @admin_place.coords, description: @admin_place.description, info: @admin_place.info, latitude: @admin_place.latitude, longitude: @admin_place.longitude, name: @admin_place.name, status: @admin_place.status, type: @admin_place.type } }
    end

    assert_redirected_to admin_place_url(Admin::Place.last)
  end

  test "should show admin_place" do
    get admin_place_url(@admin_place)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_place_url(@admin_place)
    assert_response :success
  end

  test "should update admin_place" do
    patch admin_place_url(@admin_place), params: { admin_place: { coords: @admin_place.coords, description: @admin_place.description, info: @admin_place.info, latitude: @admin_place.latitude, longitude: @admin_place.longitude, name: @admin_place.name, status: @admin_place.status, type: @admin_place.type } }
    assert_redirected_to admin_place_url(@admin_place)
  end

  test "should destroy admin_place" do
    assert_difference("Admin::Place.count", -1) do
      delete admin_place_url(@admin_place)
    end

    assert_redirected_to admin_places_url
  end
end
