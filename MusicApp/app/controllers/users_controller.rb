require 'BCrypt'

class UsersController < ApplicationController

  def create
    unless user_exists?
      @user = User.new(user_params)
      if @user.save
        log_in!(@user)
        redirect_to bands_url
      else
        flash[:errors] = @user.errors.full_messages
        redirect_to new_session_url
      end
    else
      flash[:errors] = ["User already exists"]
      redirect_to new_session_url
    end
  end

  def new
    @user = User.new
    render :new
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user
      render user_url(@user)
    else
      redirect_to bands_url
    end
  end

  def user_exists?
    User.find_by(email: params[:user][:email])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
