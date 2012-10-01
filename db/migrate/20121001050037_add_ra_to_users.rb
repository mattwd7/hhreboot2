class AddRaToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :is_ra, :boolean, :default => false
  end
end
