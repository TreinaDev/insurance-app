class ApplicationController < ActionController::Base
  def check_if_admin
    redirect_to root_path, notice: t('.authorization_failure') if current_user.employee?
  end
end
