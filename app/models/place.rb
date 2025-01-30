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
end
