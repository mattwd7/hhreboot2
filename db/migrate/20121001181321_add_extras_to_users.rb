class AddExtrasToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :locked_at, :datetime, :default => nil
  	add_column :users, :receive_textbook_emails, :boolean, :default => true
  end
end
