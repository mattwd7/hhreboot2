class Library < ActiveRecord::Base
  attr_accessible :book_id, :user_id
  
  belongs_to :user
  belongs_to :book, :class_name => "Course"
end
