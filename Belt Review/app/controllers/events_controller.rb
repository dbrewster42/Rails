class EventsController < ApplicationController
	before_action :set_event, only: [:add_member, :show, :edit, :update, :com_params, :com_create]
	before_action :verify_event, only: [:update, :destroy, :add_member]
  def index
  	@ea = Event.where(state: current_user.state)
  	@eventso = Event.where.not(state: current_user.state)
  	@eventsa = @ea.left_joins(:members).group(:id).order('COUNT(members.id) DESC')
  	@joined_events = current_user.events_joined
  	# @attendees = Event.where(attendees: current_user)
  	# @this_member = User.where(members:)
  end
  def create
  	@event = Event.create(event_params)
  	if @event.valid?
  		redirect_to "/events"
  	else
      flash[:errors] = @event.errors.full_messages
  		redirect_to '/events', alert: "Failure"
  	end
  end
  def add_member  	
  	# @event = Event.find_by(id: params[:id])
  	puts "test one #{@event.name}"
  	puts "test2 #{current_user.name}"
  	m = Member.create(user:current_user, event:@event)
  	if m.valid?
  		redirect_to '/events', alert: "Success"
  	else
  		redirect_to '/events', alert: "Failure"
  	end
  end

  def show  	
  	@members = Member.where(event: @event)
  	@comments = Comment.where(event: params[:id])
  end
  def com_create
  	@comment = Comment.create(com_params)
  	if @comment.valid?
  		redirect_to "/events/#{@event.id}"
  	else
  		redirect_to "/events/#{@event.id}", alert: "Your comment isn't worth displaying"
  	end
  end
  def edit
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #{@event}"
  end 
  def update
    if @event.update(event_params)
      redirect_to "/events/#{@event.id}"
    else
      flash[:errors] = @event.errors.full_messages
      redirect_to "/events/#{@event.id}/edit"
      # , alert: "Your event isn't worthy of our site"
    end
  end 
  private
  def com_params
  	params.require(:comment).permit(:content).merge(user: current_user, event: @event)
  end
  def event_params
  	params.require(:event).permit(:name, :date, :state).merge(user: current_user)
  end
  def set_event
	@event = Event.find_by(id: params[:id])
	unless @event
		puts "Nice TRY!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  		redirect_to "/error", alert: "Not a valid event"
  	end
  end
  def verify_event
    if current_user != @event.user
      redirect_to "/error", alert: "Cheater Cheater"
    
    end
  end 
end
