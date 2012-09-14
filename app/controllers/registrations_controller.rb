class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    main_app.user_profile_path(:user => resource)
  end
  
  def after_update_path_for(resource)
    main_app.user_profile_path(:user => resource)
  end
end