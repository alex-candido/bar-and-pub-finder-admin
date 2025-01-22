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
require "test_helper"

class PlaceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
