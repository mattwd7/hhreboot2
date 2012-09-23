Forem::Topic.class_eval do	
	after_create :remove_subscription

	def remove_subscription
		unsubscribe_user(user_id)
	end


end