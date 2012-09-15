class FixCoursesTypo < ActiveRecord::Migration
  def change
  	remove_column :courses, :title
	add_column :courses, :title, :string
	add_column :courses, :field_id, :integer
  end
end
