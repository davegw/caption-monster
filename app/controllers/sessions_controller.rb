class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.authenticate(params[:email].downcase, params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to root_path, :notice => "Logged In!"
    elsif @user.nil?
      flash.alert = "Email address does not exist."
      redirect_to log_in_path
    else
      flash.alert = "Invalid password."
      redirect_to log_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => "Logged out"
  end
end
