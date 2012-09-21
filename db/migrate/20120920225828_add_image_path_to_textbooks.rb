class AddImagePathToTextbooks < ActiveRecord::Migration
  def change
  	add_column :textbooks, :image_path, :string
  end
end
