class SecretsController < ApplicationController
  def index
  	@secrets = Secret.all
  	@mysecrets = current_user.secrets.all
  	@mylikedsecrets = current_user.liked_secrets.all
  end
  def new
  	redirect_to show_user_path(current_user.id)
  end
  def create
  	puts "yayaya #{current_user.id}"
  	@sec = Secret.create(sec_params)
  	if @sec.valid?
  		redirect_to "/secrets"
  	else
  		redirect_to show_user_path(current_user.id)
  	end
  end
  def destroy
  	@sec = Secret.find_by(id: params[:id])
  	@sec.destroy
  	redirect_to "/secrets", alert: "Secret secreted"
  end
  def lcreate  	
  	puts "We've started!"
  	@sec = Secret.find_by(id: params[:secret_id])
  	puts "WERE ALMOST THERE #{@sec}"
  	@like = Like.create(user: current_user, secret: @sec)
  	puts "WERE HERE AND LOVING IT #{@like}"
  	if @like.valid?
  		redirect_to "/secrets", alert: "Liked"
  	else
  		redirect_to "/secrets", alert: "Failure"
  	end
  end
  def ldestroy
  	@sec = Secret.find_by(id: params[:secret_id])
  	@like = Like.find_by(secret: @sec, user: current_user)
  	puts "We dont like you no mo #{@like}"
  	@like.destroy
  	redirect_to "/secrets"
  end
  private
  def sec_params
  	params.require(:secret).permit(:content).merge(user: current_user)
  end
end
