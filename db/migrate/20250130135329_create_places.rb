# frozen_string_literal: true

class CreatePlaces < ActiveRecord::Migration[7.2]
  def change
    create_table :places do |t|
      t.string :name, null: false
      t.text :description
      t.jsonb :info, default: {}
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.st_point :coords, null: false, geographic: true
      t.integer :type, default: 0
      t.integer :status, default: 0

      t.timestamps

      t.index :coords, using: :gist
      t.index %i[latitude longitude]

      t.index :type
      t.index :status
    end
  end
end
