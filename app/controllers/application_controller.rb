class ApplicationController < ActionController::Base
  def check_user
    redirect_to root_path if current_user.nil?
  end
end
