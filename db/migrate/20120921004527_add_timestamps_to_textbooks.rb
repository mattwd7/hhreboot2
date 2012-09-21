class AddTimestampsToTextbooks < ActiveRecord::Migration
  def change
  	add_column :textbooks, :created_at, :datetime
  end
end
