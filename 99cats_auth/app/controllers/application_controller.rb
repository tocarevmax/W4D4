class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def login!(user)
    session[:session_token] = user[:session_token]
  end

  helper_method :current_user
  helper_method :logged_in?
  helper_method :owned_by_current_user?

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def owned_by_current_user?
    current_user.cats.where(id: params[:id]).length > 0
  end

  def logged_in?
    !!current_user
  end

  def to_cat_index
    redirect_to cats_url
  end
end
