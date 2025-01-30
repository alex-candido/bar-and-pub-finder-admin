Enum Status {
  ACTIVE
  INACTIVE
}

Enum Role {
  ADMIN
  EDITOR
  REGISTERED
}

Enum UserPlaceRole {
  OWNER
  MANAGER
  STAFF
  VISITOR
}

Enum PlaceType {
  BAR
  PUB
  RESTAURANT
  CAFE
  NIGHTCLUB
  BREWERY
  WINERY
  FOOD_TRUCK
  COCKTAIL_BAR
  SPORTS_BAR
  LOUNGE
  ROOFTOP_BAR
}

Table User {
  id integer [primary key]

  name varchar(255)
  username varchar(255) 
  email varchar(255)
  info json [null]

  role Role [default: "REGISTERED"]
  status Status [default: "ACTIVE"]
  
  created_at timestamp
  updated_at timestamp
}

Table UserLocation {
  id integer [primary key]

  info json [null]

  latitude float
  longitude float 
  coords geography(Point, 4326)

  status Status [default: "ACTIVE"] 

  created_at timestamp
  updated_at timestamp
}


Table Place {
  id integer [primary key]

  name varchar(255) 
  description text
  info json [null]

  latitude float
  longitude float 
  coords geography(Point, 4326)

  type PlaceType [default: "BAR"]
  status Status [default: "ACTIVE"] 

  created_at timestamp 
  updated_at timestamp
}

Table UserPlace {
  id integer [primary key]

  user_id integer [ref: > User.id]
  place_id integer [ref: > Place.id]

  role UserPlaceRole [default: "VISITOR"]
  status Status [default: "ACTIVE"] 

  created_at timestamp
  updated_at timestamp
}


