class CoursesQuarters < ActiveRecord::Base
  attr_accessible :course_id, :quarter_id
  
  belongs_to :course
  belongs_to :quarter
end
