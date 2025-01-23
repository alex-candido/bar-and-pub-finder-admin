# frozen_string_literal: true

class Admin::DashboardController < Admin::BaseController
  # GET /admin/dashboard or /admin/places.json
  def index
    @places = Place.all
    @places_json = @places.to_json()
  end
end
