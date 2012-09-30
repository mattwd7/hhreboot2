class UserAttrbiutesForTestBank < ActiveRecord::Migration
  def change
  	add_column :users, :uploads, :integer, :default => 0
  	add_column :users, :legitimate_uploader, :boolean, :default => false
  end
end
