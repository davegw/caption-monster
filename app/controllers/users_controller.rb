class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(:email => params[:user][:email].downcase, 
                     :name => params[:user][:name], 
                     :password => params[:user][:password], 
                     :password_confirmation => params[:user][:password_confirmation],
                     :status_id => UserStatus::REGISTERED,
                     :registered_at => Time.now)
    if @user.save
      @user.transfer_unregistered!(current_user) if current_user && !current_user.registered?
      session[:user_id] = @user.id
      flash[:notice] = "Account Registered!"
      redirect_to root_url
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