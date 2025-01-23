class Admin::DashboardController < Admin::BaseController
  def index
    reference_point = Geo.point(-3.730616694563694, -38.59304070076367)
    distance_km = 5

    @places_nearby = Place.g_near(reference_point, distance_km)

    @places_json = @places_nearby.map do |place|
      {
        id: place.id,
        name: place.name,
        latitude: place.latitude,
        longitude: place.longitude,
        description: place.description
      }
    end
  end
end