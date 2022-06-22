# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :null_session
  rescue_from ActionController::InvalidAuthenticityToken do |_exception|
    redirect_back(fallback_location: root_path)
  end

  protected

  def configure_permitted_parameters
    attributes = %i[first_name last_name city county email password password_confirmation current_password]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end
end
