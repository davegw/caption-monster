class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(:email => params[:user][:email], :name => params[:user][:name])
    redirect_to show_user_url(@user.id)
  end

  def show
    @user = User.find(params[:id])
  end
end