class Course < ActiveRecord::Base
   attr_accessible :title, :field_id
   
   belongs_to :field
   has_and_belongs_to_many :quarters, :join_table => "courses_quarters"
   has_one :textbook
   has_many :users, :through => :quarters
   has_many :exams

end