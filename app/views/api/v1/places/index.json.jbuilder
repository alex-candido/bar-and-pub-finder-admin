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
  json.info do
    json.city place.info['city']
    json.state place.info['state']
    json.region place.info['region']
    json.suburb place.info['suburb']
    json.country place.info['country']
    json.zip_code place.info['zip_code']
    json.street_name place.info['street_name']
    json.country_code place.info['country_code']
    json.street_number place.info['street_number']
  end
end
