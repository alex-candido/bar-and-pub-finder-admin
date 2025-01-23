# frozen_string_literal: true

require "application_system_test_case"

class Admin::PlacesTest < ApplicationSystemTestCase
  setup do
    @admin_place = admin_places(:one)
  end

  test "visiting the index" do
    visit admin_places_url
    assert_selector "h1", text: "Places"
  end

  test "should create place" do
    visit admin_places_url
    click_on "New place"

    fill_in "Coords", with: @admin_place.coords
    fill_in "Description", with: @admin_place.description
    fill_in "Info", with: @admin_place.info
    fill_in "Latitude", with: @admin_place.latitude
    fill_in "Longitude", with: @admin_place.longitude
    fill_in "Name", with: @admin_place.name
    fill_in "Status", with: @admin_place.status
    fill_in "Type", with: @admin_place.type
    click_on "Create Place"

    assert_text "Place was successfully created"
    click_on "Back"
  end

  test "should update Place" do
    visit admin_place_url(@admin_place)
    click_on "Edit this place", match: :first

    fill_in "Coords", with: @admin_place.coords
    fill_in "Description", with: @admin_place.description
    fill_in "Info", with: @admin_place.info
    fill_in "Latitude", with: @admin_place.latitude
    fill_in "Longitude", with: @admin_place.longitude
    fill_in "Name", with: @admin_place.name
    fill_in "Status", with: @admin_place.status
    fill_in "Type", with: @admin_place.type
    click_on "Update Place"

    assert_text "Place was successfully updated"
    click_on "Back"
  end

  test "should destroy Place" do
    visit admin_place_url(@admin_place)
    click_on "Destroy this place", match: :first

    assert_text "Place was successfully destroyed"
  end
end
