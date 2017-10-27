class UsersController < ApplicationController

  before_action :to_cat_index, only: [:new, :create], if: -> { logged_in? }


  def new
    render :new
  end

  def create
    user = User.new(user_params)
    if user.save
      login!(user)
      redirect_to cats_url
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:users).permit(:username, :password)
  end

end
