# frozen_string_literal: true

json.array! @places, partial: "admin/places/admin_place", as: :admin_place
