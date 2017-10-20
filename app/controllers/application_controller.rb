class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def is_manager?
    return true if User.find(session[:user_id]).role == "manager"
    false
  end
end
