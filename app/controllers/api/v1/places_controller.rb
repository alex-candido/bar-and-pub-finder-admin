# frozen_string_literal: true

class Api::V1::PlacesController < Api::BaseController
  def index
    sw_lat = params[:sw_lat].to_f
    sw_lng = params[:sw_lng].to_f
    ne_lat = params[:ne_lat].to_f
    ne_lng = params[:ne_lng].to_f

    @places = Place.g_within_box(
      Geo.point(sw_lat, sw_lng),
      Geo.point(ne_lat, ne_lng)
    ).limit(200)
  end
end
