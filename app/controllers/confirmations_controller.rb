class ConfirmationsController < Devise::ConfirmationsController
  protected

	def after_confirmation_path_for(resource_name, resource)
      main_app.user_profile_path
    end
  
end