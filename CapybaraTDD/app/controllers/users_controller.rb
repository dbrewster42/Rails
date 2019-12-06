class UsersController < ApplicationController
  def new
  end
  def create
  	@user = User.new(params.require(:user).permit(:first, :last, :email))
  	if @user.save
    	flash[:notice] = ['User successfully created']
    	redirect_to user_path(@user.last)
  	else
    	flash[:notice] = @user.errors.full_messages
    	redirect_to new_user_path
  	end
  end
  def show
  	@user = User.find_by(last: params[:id])
  end
end
