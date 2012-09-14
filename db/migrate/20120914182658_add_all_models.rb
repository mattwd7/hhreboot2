class AddAllModels < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.boolean :new_messages, :default => false
    end

  	create_table :buildings do |t|
  		t.string :name
  		t.integer :population
  	end

  	create_table :courses do |t|
  		t.string :title
  		t.integer :title
  	end

  	create_table :fields do |t|
  		t.string :title
  		t.string :abbr
  	end

  	create_table :quarters do |t|
  		t.string :term
  		t.integer :user_id
  	end

  	create_table :textbooks do |t|
  		t.integer :user_id
  		t.integer :course_id
  		t.boolean :own_it
  		t.text :description
  		t.string :terms_of_exchange
  		t.integer :price
  		t.string :condition
  	end

  	create_table :friendships do |t|
  		t.integer :friend_id
  		t.integer :user_id

      t.timestamps
  	end

  	create_table :messages do |t|
  		t.integer :recipient_id
  		t.integer :user_id
  		t.boolean :unread, :default => true
  		t.text :text
  		t.string :subject
   		t.boolean :replied_to, :default => false
   		t.boolean :trashed, :default => false
   		t.datetime :trash_time

      t.timestamps
 	  end

   	create_table :courses_quarters, :id => false do |t|
   		t.references :course
   		t.references :quarter
   	end

    add_index :courses_quarters, [:course_id, :quarter_id]

    remove_column  :users, :username

    add_column  :users, :username, :string
    add_column :users, :major, :string
    add_column :users, :year, :integer
    add_column :users, :major2, :string, :default => nil
    add_column :users, :minor, :string, :default => nil
    add_column :users, :minor2, :string, :default => nil
    add_column :users, :about_me, :text
    add_index :users, :username, {:unique => true}

    remove_column :forem_posts, :state
    remove_column :forem_topics, :state
    add_column :forem_topics, :state, :string, :default => 'approved'
    add_column :forem_posts, :state, :string, :default => 'approved'
    add_index :forem_topics, :state
    add_index :forem_posts, :state

  end
end
