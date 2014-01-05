class GuestsController < ApplicationController
  require 'rubygems' 
  require 'nokogiri'
  require 'open-uri'
  
  # New,check,update_response definition for testing 
  def new    
  end  
  def check
  end  
  def updateresponse
  end    
  
  def create
    message = ""
    reg_ids = Array.new
    @count = 0
    request_type = params[:request_type]
    guest_list_xml = Nokogiri::XML(params[:guests])
    event_id = guest_list_xml.xpath('//rsveep/@eventId').text
    host = guest_list_xml.xpath('//rsveep/@host').text
    @user = User.find_by_number host
    if @user.nil?
      @message = 'Invalid user'
      render(:template => "guests/failed" , :formats => [:xml], :handlers => :builder, :layout => false)
      return
    end    
    
    @event = Event.find_by_eventId_and_user_id  event_id,@user
    if request_type == 'forward'
      @event = Event.find_by_eventId event_id
    elsif @event.nil?
      @message = 'Event does not exist'
      render(:template => "guests/failed" , :formats => [:xml], :handlers => :builder, :layout => false)
      return
    end
    
    
    guest_list_xml.xpath('//rsveep/guest/@number').each do |node|
      user = node.text
      if user != host
        @guest = Guest.new(:event=>@event, :user=>user, :response=>'')
        if !@guest.save
          message = message + user + ","
        else 
          @guest_user = User.find_by_number user
          if !@guest_user.nil?
            reg_ids <<  @guest_user.gcmid 
          end 
        end
        @count = @count + 1
      end 
    end
    if message == "" and @count != 0
      @response = send_notification reg_ids,"event_invite"
      render(:template => "guests/success" , :formats => [:xml], :handlers => :builder, :layout => false)
    else
      message = message + " could not be added to the guest list"
      @message = message
      render(:template => "guests/failed" , :formats => [:xml], :handlers => :builder, :layout => false)
    end
  end
  
  def myguests
    @user = User.find_by_number params[:number]
    if @user.nil?
      @message = 'Invalid user'
      render(:template => "guests/failed" , :formats => [:xml], :handlers => :builder, :layout => false)
      return
    end
    
    @event = Event.find_by_eventId_and_user_id  params[:event],@user
    if @event.nil?
      @message = 'Event does not exist'
      render(:template => "guests/failed" , :formats => [:xml], :handlers => :builder, :layout => false)
      return
    end
    
    @guests = Guest.where :event_id=> @event
    render(:template => "guests/myguests" , :formats => [:xml], :handlers => :builder, :layout => false)
  end
  
  def guestevents
    @user = User.find_by_number params[:number]
    if @user.nil?
      @message = 'Invalid user'
      render(:template => "guests/failed" , :formats => [:xml], :handlers => :builder, :layout => false)
      return
    end
    
    @guests = Guest.where :user => "#{params[:number]}"
    render(:template => "guests/guestevents" , :formats => [:xml], :handlers => :builder, :layout => false)
  end
  
  def guestresponse
    reg_ids = Array.new
    @user = User.find_by_number params[:number]
    if @user.nil?
      @message = 'Invalid user'
      render(:template => "guests/failed" , :formats => [:xml], :handlers => :builder, :layout => false)
      return
    end
    
    @event = Event.find_by_eventId params[:event]
    if @event.nil?
      @message = 'Event does not exist'
      render(:template => "guests/failed" , :formats => [:xml], :handlers => :builder, :layout => false)
      return
    end
    
    @guest = Guest.find_by_event_id_and_user  @event, "#{params[:number]}"
    
    unless @guest.nil?
      if @guest.update(:response => params[:response])
        reg_ids <<  @event.user.gcmid
        @response = send_notification reg_ids,"guest_response"
        render(:template => "guests/success_response" , :formats => [:xml], :handlers => :builder, :layout => false)
        return
      else
        @message = 'Could not set response. Response can only be Yes, No or May be'
        render(:template => "guests/failed" , :formats => [:xml], :handlers => :builder, :layout => false)
        return
      end
    else
      @message = 'You have not been invited to this event'
      render(:template => "guests/failed" , :formats => [:xml], :handlers => :builder, :layout => false)
    end
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
