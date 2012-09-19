class ConfirmationsController < Devise::ConfirmationsController
  protected

	def after_confirmation_path_for(resource_name, resource)
      main_app.homepage_path
    end
  
end