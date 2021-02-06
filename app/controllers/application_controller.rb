class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?
  def current_user
    @current_user ||=User.find(session[:user_id]) if session[:user_id]
  end

  def current_user
    # When we reference current_user method everytime this will make db Query
    # User.find(session[:user_id]) if session[:user_id]
    #
    #If we already referenced current_user have it available we'll simply return
    @current_user ||=User.find(session[:user_id]) if session[:user_id]

  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert]="You must be logged in"
      redirect_to login_path
    end
  end

end
