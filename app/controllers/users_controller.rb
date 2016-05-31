class UsersController < ApplicationController

  before_filter :set_user, only: [:show, :update]

  def new
    @user = User.new
  end

  def create
    if User.exists?(params[:user][:id])
      @user = User.find(params[:user][:id])
      login
    else
      @user = User.new(user_params)
      @user.save
      login

    end
  end

  def signin

  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def show

  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :password, :happiness, :tickets, :nausea, :height, :admin)
  end
end
