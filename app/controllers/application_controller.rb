class ApplicationController < ActionController::Base

  before_filter :set_current_term
	before_filter :set_premium_exam_benchmark
	def set_current_term
		@current_term = "Fall 2012"
	end
  def set_premium_exam_benchmark
    @premium_exam_benchmark = 4
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
