class Field < ActiveRecord::Base
  attr_accessible :title, :abbr
  
  has_many :courses
  
end
