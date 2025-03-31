class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Admin authentication for specific actions (post-related actions)
  def authenticate_admin!
    redirect_to root_path, alert: "Access denied." unless current_user&.admin?
  end

  protected

  def configure_permitted_parameters
    # Permit the custom fields during sign-up and account update
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :ime, :priimek, :telefonska_stevilka, :naslov, :mesto, :email, :password, :password_confirmation
    ])

    devise_parameter_sanitizer.permit(:account_update, keys: [
      :ime, :priimek, :telefonska_stevilka, :naslov, :mesto, :email, :password, :password_confirmation
    ])
  end
end
