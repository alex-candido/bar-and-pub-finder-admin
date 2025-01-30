# == Schema Information
#
# Table name: places
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :text
#  info        :jsonb
#  latitude    :float            not null
#  longitude   :float            not null
#  coords      :geography        not null, point, 4326
#  type        :integer          default(0)
#  status      :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
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

  after_validation :reverse_geocode, if: ->(obj) {
    obj.latitude.present? && obj.longitude.present? &&
    (obj.latitude_changed? || obj.longitude_changed?)
  }

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def self.ransackable_attributes(auth_object = nil)
    %w(name status type)
  end

  private
    def set_coords
      self.coords = Geo.point(latitude, longitude) if latitude_changed? || longitude_changed?
    end

    def normalize_coordinates
      self.latitude = latitude.to_f.round(6) if latitude
      self.longitude = longitude.to_f.round(6) if longitude
    end
end
