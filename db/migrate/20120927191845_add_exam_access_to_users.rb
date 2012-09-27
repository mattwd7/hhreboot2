class AddExamAccessToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :accessible_exams, :string
  end
end
