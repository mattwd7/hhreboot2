class Textbook < ActiveRecord::Base
   attr_accessible :user_id, :course_id, :own_it, :description, :terms_of_exchange, :price, :condition
   # o:wn_it = false => user is looking for the book
   # :own_it = true => user has the book
   # :terms_of_exchange can be "sale", "trade", "either"
   validates :course_id, :presence => true
   validates :price, :presence => true

   belongs_to :user
   belongs_to :course
end
