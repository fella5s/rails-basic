class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  
  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  protected
  
  def logged_in?
    unless session[:user_id]
      render :file => "public/401.html", :status => :unauthorized
      return false
    else
      return true
    end
  end
  
  def is_admin?
    unless current_user.is_admin?
      session[:user_id] = nil
      render :file => "public/401.html", :status => :unauthorized
      return false
    else
      return true
    end  end
  
end
