class SessionsController < ApplicationController
  skip_before_action :require_login
  def new  	
  end
  def create
  	#see if User is in db with email/username
  	# set that to variable
  
  	# if user, auth. password of that user
  	# 	if valid pw, login user, set id in session and redirect to main page
  	# 	else invalid pw, display errors and redirect to 'new'
  	# else false, display error and redirect to 'new'

  	@user = User.find_by(email: params[:email])
  	if @user && @user.authenticate(params[:password])
  		session[:user_id] = @user.id
  		redirect_to "/users/#{@user.id}"
  	else
  		flash[:alert]="Incorrect username/password"
  		redirect_to '/sessions/new'
  	end

  	# @user = User.find_by_email(params[:email]).try(:authenticate, params[:password])
  end
  def destroy
  	session.clear
  	redirect_to '/sessions/new'
  end
end
