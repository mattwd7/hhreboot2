class Message < ActiveRecord::Base
  attr_accessible :recipient_id, :user_id, :unread, :text, :subject
  attr_accessible :replied_to, :trashed, :trash_time
  # unread, replied_to, trashed HAVE DEFAULTS
  
  belongs_to :user
  
  validates :text, :presence => true
  validates :subject, :presence => true
  
end
