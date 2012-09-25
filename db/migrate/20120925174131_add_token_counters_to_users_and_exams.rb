class AddTokenCountersToUsersAndExams < ActiveRecord::Migration
  def change
  	add_column :users, :exam_votes, :integer, :default => 0
  	add_column :exams, :prev_best, :integer, :default => 0
  end
end
