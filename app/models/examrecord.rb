class Examrecord < ActiveRecord::Base
   attr_accessible :user_id, :exam_id, :vote, :downloaded

   belongs_to :user
   belongs_to :exam

end