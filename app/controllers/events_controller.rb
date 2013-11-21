class EventsController < ApplicationController
  def new
    
  end
  
  def search
    
  end
  
  def find
    @event = Event.find_by_eventId params[:eventId]
    if @event.nil?
      @message = 'Could not find the event. The event might have taken place'
      render(:template => "events/failed" , :formats => [:xml], :handlers => :builder, :layout => false)
    else
      render(:template => "events/event" , :formats => [:xml], :handlers => :builder, :layout => false)
    end
  end
  
  def create
    @user = User.find_by_number params[:host]
    if @user.nil?
      @message = 'Invalid user'
      render(:template => "events/failed" , :formats => [:xml], :handlers => :builder, :layout => false)
      return
    end
    
    eventid = gen_event_id
    until validate_event_id eventid
      eventid = gen_event_id
    end
    @event = create_event_from_params
    @event.eventId = eventid
    @event.user = @user
    
    if @event.save
      render(:template => "events/success" , :formats => [:xml], :handlers => :builder, :layout => false)
    else
      @message = 'Could not create event'
      render(:template => "events/failed" , :formats => [:xml], :handlers => :builder, :layout => false)
    end
  end
  
  private
  def gen_event_id
    return "RSVEEP_#{rand(1000...10000)}#{Time.now.strftime('%d/%m/%Y')}"
  end
  
  private 
  def validate_event_id (eventId)
    @event = Event.find_by_eventId eventId
    return @verification.nil?
  end 
  
  private 
  def create_event_from_params
    @event = Event.new
    @event.title = params[:title]
    @event.subtitle = params[:subtitle]
    @event.address = params[:address]
    @event.city = params[:city]
    @event.country = params[:country]
    @event.dateTime = params[:dateTime].to_time
    @event.dressing = params[:dressing]
    @event.image = params[:image]
    @event.latitude = params[:latitude].to_f
    @event.longitude = params[:longitude].to_f
    @event.notes = params[:notes]
    @event.postcode = params[:postcode]
    @event.privacy = params[:privacy]
    @event.state = params[:state]
    @event.type = params[:type]
    @event.venue = params[:venue]
    return @event
  end
end
