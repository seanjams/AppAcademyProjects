class SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )
    if @user.nil?
      flash[:errors] = ["Incorrect Email/Password"]
      redirect_to new_session_url
    else
      log_in!(@user)
      redirect_to bands_url
    end
  end

  def new
    render :new
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end

end
