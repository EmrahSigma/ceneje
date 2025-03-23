class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  def index
    # Fetch all the products you want to display on the homepage
    @products = Product.all
  end
end
