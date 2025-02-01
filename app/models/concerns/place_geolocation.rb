# frozen_string_literal: true

module PlaceGeolocation
  extend ActiveSupport::Concern
  included do
    def self.g_near(point, distance)
      where(
        "ST_DWithin(coords, :point, :distance)",
        { point: Geo.to_wkt(point), distance: distance * 1000 }
      )
    end

    def self.g_within_box(sw_point, ne_point)
      where(
        "coords && ST_MakeEnvelope(:sw_lon, :sw_lat, :ne_lon, :ne_lat, #{
            Geo::SRID
          })",
        {
          sw_lon: sw_point.longitude,
          sw_lat: sw_point.latitude,
          ne_lon: ne_point.longitude,
          ne_lat: ne_point.latitude
        }
      )
    end

    def self.g_within_polygon(points)
      polygon = Geo.polygon(points)
      where("ST_Covers(:polygon,coords)", polygon: Geo.to_wkt(polygon))
    end
  end
end
