class AddQueueToCoursesAndOwnerToUsers < ActiveRecord::Migration
  def change
  	add_column :courses, :queue, :integer
  	add_column :users, :owner, :boolean, :default => false
  end
end
