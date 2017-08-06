class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :token, :string
    add_column :users, :time_zone, :string
    add_column :users, :active, :boolean
  end
end
