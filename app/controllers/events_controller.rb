class EventsController < ApplicationController
  def new
    
  end
  
  def search
    
  end
  
  def myevents
    @user = User.find_by_number params[:host]
    if @user.nil?
      @message = 'Invalid user'
      render(:template => "events/failed" , :formats => [:xml], :handlers => :builder, :layout => false)
      return
    end
    @events = Event.where :user_id=>@user
    if @events.nil?
      @message = 'You have not created an event'
      render(:template => "events/failed" , :formats => [:xml], :handlers => :builder, :layout => false)
    else
      render(:template => "events/myevents" , :formats => [:xml], :handlers => :builder, :layout => false)
    end
    
  end
  
  def cancel
    reg_ids = Array.new
    @user = User.find_by_number params[:host]
    if @user.nil?
      @message = 'Invalid user'
      render(:template => "events/failed" , :formats => [:xml], :handlers => :builder, :layout => false)
      return
    end
    @event = Event.find_by_eventId_and_user_id params[:eventId],@user
    if @event.nil?
      @message = 'Event does not exist'
      render(:template => "events/failed" , :formats => [:xml], :handlers => :builder, :layout => false)
    end
    
    if @event.update(:status => 'cancelled')
      @guests = Guest.where :event_id => @event.id    
      @guests.each do |guest|
        @invitedUser = User.find_by_number guest.user
        if !@invitedUser.nil?
           reg_ids <<  @invitedUser.gcmid
        end
      end

      send_notification reg_ids,"event_invite"
      render(:template => "events/success" , :formats => [:xml], :handlers => :builder, :layout => false)
    else
      @message = 'Could not update event'
      render(:template => "events/failed" , :formats => [:xml], :handlers => :builder, :layout => false)
    end
    
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
  
  def update
    reg_ids = Array.new
    
    @user = User.find_by_number params[:host]
    if @user.nil?
      @message = 'Invalid user'
      render(:template => "events/failed" , :formats => [:xml], :handlers => :builder, :layout => false)
      return
    end
    @event = Event.find_by_eventId_and_user_id params[:eventId],@user
    if @event.nil?
      @message = 'Event does not exist'
      render(:template => "events/failed" , :formats => [:xml], :handlers => :builder, :layout => false)
    end
    
    
    if @event.update(:title => params[:title],:subtitle =>params[:subtitle], :address =>params[:address], :city =>params[:city],
      :country =>params[:country], :dateTime=>params[:dateTime].to_time, :dressing =>params[:dressing],:image=>params[:image],
      :latitude=>params[:latitude].to_f, :longitude=>params[:longitude].to_f, :notes =>params[:notes], :postcode =>params[:postcode],
      :privacy=>params[:privacy], :state=>params[:state], :type =>params[:type], :venue=>params[:venue])
    
      @guests = Guest.where :event_id => @event.id    
      @guests.each do |guest|
        @invitedUser = User.find_by_number guest.user
        if !@invitedUser.nil?
           reg_ids <<  @invitedUser.gcmid
        end
      end

      send_notification reg_ids,"event_invite"
      render(:template => "events/success" , :formats => [:xml], :handlers => :builder, :layout => false)
    else
      @message = 'Could not update event'
      render(:template => "events/failed" , :formats => [:xml], :handlers => :builder, :layout => false)
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
  
  private
  def send_notification (reg_ids, key)    
    GCM.host = 'https://android.googleapis.com/gcm/send'
    GCM.format = :json
    GCM.key = "AIzaSyDiyNj9eta22S10N1CZ9zKhzsNAKIJ-j9M"
    
    destination = reg_ids.to_ary
    if destination.size > 0
      data = {:message => "test"}
      return GCM.send_notification( destination, data, :collapse_key => key, :time_to_live => 3600, :delay_while_idle => false )
    end    
  end
end
