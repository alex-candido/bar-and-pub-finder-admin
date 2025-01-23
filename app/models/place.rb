# frozen_string_literal: true

# == Schema Information
#
# Table name: places
#
#  id          :bigint           not null, primary key
#  coords      :geography        not null, point, 4326
#  description :text
#  info        :jsonb
#  latitude    :float            not null
#  longitude   :float            not null
#  name        :string           not null
#  status      :integer          default("active")
#  type        :integer          default("bar")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_places_on_coords                  (coords) USING gist
#  index_places_on_latitude_and_longitude  (latitude,longitude)
#  index_places_on_status                  (status)
#  index_places_on_type                    (type)
#
class Place < ApplicationRecord
  self.inheritance_column = :_type_disabled

  before_save :set_coords
  before_validation :normalize_coordinates

  include PlaceGeolocation

  attr_accessor :city, :state, :country, :zip_code, :street_name, :street_number, :suburb, :region

  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  enum status: { active: 0, inactive: 1 }, _prefix: true

  enum type: { bar: 0, pub: 1, restaurant: 2, cafe: 3, nightclub: 4, brewery: 5, winery: 6, food_truck: 7, cocktail_bar: 8, sports_bar: 9, lounge: 10, rooftop_bar: 11 }, _prefix: true

  scope :active_places, -> { where(status: :active) }
  scope :by_type, ->(type) { where(type: type) }
  scope :created_between, ->(start_date, end_date) { where(created_at: start_date..end_date) }
  scope :with_info_field, ->(field, value) { where("info->>'#{field}' = ?", value) }

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.info = {
        street_name: geo.data["address"]["road"],
        street_number: geo.data["address"]["house_number"],
        suburb: geo.data["address"]["suburb"],
        city: geo.city,
        state: geo.state,
        region: geo.data["address"]["region"],
        zip_code: geo.postal_code,
        country: geo.data["address"]["country"],
        country_code: geo.country_code,
      }
    end
  end

  after_validation :reverse_geocode, if: ->(obj) {
    obj.latitude.present? && obj.longitude.present? &&
    (obj.latitude_changed? || obj.longitude_changed?)
  }

  private
    def set_coords
      self.coords = Geo.point(latitude, longitude) if latitude_changed? || longitude_changed?
    end

    def normalize_coordinates
      self.latitude = latitude.to_f.round(6) if latitude
      self.longitude = longitude.to_f.round(6) if longitude
    end
end
