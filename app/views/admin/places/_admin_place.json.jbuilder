# frozen_string_literal: true

json.extract! admin_place, :id, :name, :description, :latitude, :longitude, :status, :type, :info, :coords, :created_at, :updated_at
json.url admin_place_url(admin_place, format: :json)
