class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(:email => params[:user][:email], 
                     :name => params[:user][:name], 
                     :password => params[:user][:password], 
                     :password_confirmation => params[:user][:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect_to show_user_url(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  # private
  #   def user_params
  #     params.require(:user).permit(:email, :name, :password, :password_confirm)
  #   end
end