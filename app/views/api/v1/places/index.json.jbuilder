# frozen_string_literal: true

json.array! @places do |place|
  json.id place.id
  json.name place.name
  json.description place.description
  json.type place.type
  json.status place.status
  json.latitude place.latitude
  json.longitude place.longitude
  json.created_at place.created_at
  json.updated_at place.updated_at
  json.info place.info
end
