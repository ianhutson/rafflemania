class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_user
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit({ roles: [] }, :name, :email, :password, :password_confirmation) }
        devise_parameter_sanitizer.permit(:update) { |u| u.permit({ roles: [] }, :email, :password, :password_confirmation, :image, :zip, :shipping_name, :shipping_address, :city, :current_password, :username) }
     end
end
