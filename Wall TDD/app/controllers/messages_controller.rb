class MessagesController < ApplicationController
  def index
  	if session[:user_id]
  		@user = User.find(session[:user_id])
  		puts "#{@user}"
  		puts "#{@user.name}"
  		@messages = Message.all
  	else
  		redirect_to '/users/new'  
  	end	
  end
  def new
  end
  def log
  	@user = User.new(params.require(:user).permit(:name))
  	if User.find_by(name: @user.name)
  		@user = User.find_by(name: @user.name)
  		puts "ALREADY TAKEN #{@user.id}"
  		session[:user_id] = @user.id
  		redirect_to '/messages'
  	elsif @user.save
  		puts "ITS WWWWWWWWORRRRRRRRRRRKKKKKKKKKING"
  		session[:user_id] = @user.id
  		redirect_to '/messages'	 
  	else
  		puts "WWWWWHHHHHHHHOOOOOOOOOOPPPPPPPPS"
  		redirect_to '/users/new', alert: @user.errors.full_messages
  	end
  				
  end
  def message
  	@mess = Message.create(params.require(:message).permit(:content, :user_id))
  	if @mess.valid?
  		redirect_to '/messages'
  	else
  		redirect_to '/messages', alert: @mess.errors.full_messages
  	end
  end
  def comment
  	@comm = Comment.create(params.require(:comment).permit(:content, :user_id, :message_id))
  	if @comm.valid?
  		redirect_to '/messages'
  	else
  		redirect_to '/messages', alert: @comm.errors.full_messages
  	end
  end

end
