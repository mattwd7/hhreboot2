Forem::Topic.class_eval do	
	after_create :unsubscribe_user(self.id)
end