class AddTestBankTables < ActiveRecord::Migration
  def change
  	create_table :exams do |t|
  		t.string :professor
  		t.string :term
  		t.integer :quality, :default => 0
  		t.integer :course_id
  		t.integer :user_id
  		t.integer :irrelevant_count
  		t.integer :duplicate_count
  		t.integer :misplaced_count
  		t.integer :download_count

  		t.timestamps
  	end

  	create_table :examrecords do |t|
  		t.integer :user_id
  		t.integer :exam_id
  		t.string :vote
  		t.boolean :downloaded
  	end

  	add_column :users, :test_tokens, :integer, :default => 2

  end
end
