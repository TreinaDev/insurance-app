class ApplicationController < ActionController::Base
  def check_if_admin
    redirect_to root_path, notice: t('.authorization_failure') if current_user.employee?
  end
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
