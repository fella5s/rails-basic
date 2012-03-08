class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def index
    @users = User.all
  end
  
  def show
    @user=current_user
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Account created!"
    else
      render "new"
    end
  end
  
  def update
    if current_user.update_attributes(params[:user])
      flash[:notice] = "Password saved"
      redirect_to :root
    else
      render action: :show
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = "User deleted"
    redirect_to users_path
  end
end
