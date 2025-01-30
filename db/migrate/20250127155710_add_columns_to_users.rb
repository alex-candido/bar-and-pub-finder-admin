class AddColumnsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :name, :string
    add_column :users, :username, :string
    add_column :users, :info, :jsonb, default: {}
    add_column :users, :preferences, :jsonb, default: {}
    add_column :users, :role, :integer, default: 0, null: false
    add_column :users, :status, :integer, default: 0, null: false
  end
end
