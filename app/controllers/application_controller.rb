class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method [:current_user, :logged_in?]

  def login
    if !@user.id.nil?
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    end
  end

  def current_user
    @user ||= User.find(session[:user_id]) if !session[:user_id].nil?
  end

  def logged_in?
    !!current_user
  end

end
