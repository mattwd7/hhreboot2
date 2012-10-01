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
    @upload_limit = 2
	end

  before_filter :check_locked_account
  def check_locked_account
      if current_user && current_user.locked_at != nil
          flash[:alert] = "Your account has been locked.  If you feel this was done in error or you would like a second chance, email the admins: hillheroesmods@gmail.com"
          sign_out(current_user)
      end
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
