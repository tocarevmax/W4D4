class SessionsController < ApplicationController

  before_action :to_cat_index, only: [:new, :create], if: -> { logged_in? }

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:users][:username], params[:users][:password])
    if user
      #login
      login!(user)
      redirect_to cats_url
    else
      render :new
    end
  end

  def destroy
    #logout
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
    end
    redirect_to new_session_url
  end
end
