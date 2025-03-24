class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?

  def index
    # Fetch all the products you want to display on the homepage
    @products = Product.all
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:ime, :priimek, :telefonska_stevilka, :naslov, :mesto])
    devise_parameter_sanitizer.permit(:account_update, keys: [:ime, :priimek, :telefonska_stevilka, :naslov, :mesto])
  end
end