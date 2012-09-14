class Building < ActiveRecord::Base
  attr_accessible :name, :population
  
  has_many :users
  has_many :posts, :through => :users
end
