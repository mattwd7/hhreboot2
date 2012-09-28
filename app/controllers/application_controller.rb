class ApplicationController < ActionController::Base

  before_filter :set_global_variables
	def set_global_variables
		@current_term = "Fall 2012"
    @premium_exam_benchmark = 4
    @irrelevant_count_threshold = 2
    @misplaced_count_threshold = 2
    @duplicate_count_threshold = 2
    @upvotes_per_token = 2
    @exam_votes_per_token = 5
	end

	def forem_user
		current_user
	end
  helper_method :forem_user

  protect_from_forgery

  layout :layout_by_resource
  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
  
end
