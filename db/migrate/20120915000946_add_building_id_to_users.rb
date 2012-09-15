class AddBuildingIdToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :building_id, :integer
  end
end
