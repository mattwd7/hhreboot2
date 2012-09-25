class CleanUpExamMigrations < ActiveRecord::Migration
  def change
  		remove_column :exams, :irrelevant_count
  		remove_column :exams, :duplicate_count
  		remove_column :exams, :misplaced_count
  		remove_column :exams, :download_count

  		add_column :exams, :irrelevant_count, :integer, :default => 0
  		add_column :exams, :duplicate_count, :integer, :default => 0
  		add_column :exams, :misplaced_count, :integer, :default => 0
  		add_column :exams, :download_count, :integer, :default => 0

  		add_column :exams, :description, :string
  end
end
