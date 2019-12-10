class UsersController < ApplicationController
	before_action :set_user, only: [:show, :update, :edit, :destroy]
	skip_before_action :require_login, only: [:new, :create]
  def new
  end
  def create
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
  	# @user = User.find(params[:id])
    puts "yayaya #{current_user}"
  end  
  def edit
  	# @user = User.find(params[:id])
  	user = current_user.id
  	puts "#Is this working???!! #{@user.name}"
  end
  def update
  	# @user = User.find(params[:id])
  	puts "#Is this working???!! #{@user}"
  	if @user.update(user_params)
  		redirect_to "/users/#{@user.id}"
  	else
  		flash[:errors] = @user.errors.full_messages
  		redirect_to "/users/#{@user.id}/edit" 
  	end
  end
  def destroy
  	# @user = User.find(params[:id])
  	@user.destroy
  	session.clear  	
  	redirect_to "/sessions/new", alert: "User successfully deleted"
  end
  private
  def user_params
  	params.require(:user).permit(:name, :email, :password)
  end
  def set_user
  	@user = User.find_by(id: params[:id])
  end
end


 # def update
 #  	@user = User.find(params[:id])
 #  	puts "#Is this working???!! #{@user}"
 #  	@user = User.update(user_params)
 #  	puts "#Is this working???!! #{@user[0]}"
 #  	if @user[0].valid?
 #  		redirect_to "/users/#{@user[0].id}"
 #  	else
 #  		flash[:errors] = @user[0].errors.full_messages
 #  		redirect_to "/users/#{@user[0].id}/edit" 
 #  	end
 #  end