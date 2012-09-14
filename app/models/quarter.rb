class Quarter < ActiveRecord::Base
  attr_accessible :term, :user_id
  
  belongs_to :user
  has_and_belongs_to_many :courses, :join_table => "courses_quarters"
end
