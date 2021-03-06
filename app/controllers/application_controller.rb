class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    before_filter :configure_permitted_parameters, if: :devise_controller?

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:nickname, :email, :is_female, :password, :image, :image_cache) }
            devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:nickname, :email, :password, :current_password, :is_female, :image, :image_cachess, :remove_image) }
        end
end
