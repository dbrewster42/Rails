class UsersController < ApplicationController
  def new
  end
  def update
  	if params[:password] == params[:confirm_password]
  		@user = User.create(user_params)
  		if @user.valid?
  			redirect_to "/sessions/new"
  		else
  			flash[:errors] = @user.errors.full_messages
  			redirect_to "/users/new" 
  		end
 	end
  end
  def show
  end

  def edit
  end
  private
  def user_params
  	params.require(:user).permit(:name, :email, :password)
  end
end
