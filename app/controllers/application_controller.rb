class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery
  before_filter :update_sanitized_params, if: :devise_controller?

  protected

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation)}
  end
end
