class UsersController < ApplicationController
	skip_before_action :require_login, only: [:index, :create, :login]
  before_action :set_user, only: [:edit, :update, :sdestroy]
  def index
  end
  def create
  	# if params[:password] == params[:password_confirmation]
	  	@user = User.create(user_params)
	  	if @user.valid?
	  		session[:user_id] = @user.id
	  		redirect_to '/events'
	  	else
	  		flash[:errors] = @user.errors.full_messages
	  		redirect_to '/' 
	  	end
	end
  # end
  def login
  	@user = User.find_by(email: params[:email])
  	if @user && @user.authenticate(params[:password])
  		session[:user_id] = @user.id
  		redirect_to '/events'
  	else
  		flash[:alert]= "Incorrect username/password"
  		redirect_to '/'
  	end
  end
  def edit
  end
  def sdestroy
  	# @user = User.find_by(id: params[:id])
  	if @user != current_user
      redirect_to '/events'
    end
  	session.clear
  	redirect_to '/'
  end
  def error
  end
  private
  def set_user
    @user = User.find_by(id: params[:id])
    unless @user
      redirect_to '/'
    end    
  end
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation, :state)
  end
end
