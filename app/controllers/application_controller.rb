class ApplicationController < ActionController::Base

	before_filter :set_current_term
	def set_current_term
		@current_term = "Fall 2012"
	end

	def forem_user
		current_user
	end
  helper_method :forem_user

  protect_from_forgery
  
end
