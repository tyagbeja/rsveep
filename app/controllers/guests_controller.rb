class GuestsController < ApplicationController
  require 'rubygems' 
  require 'nokogiri'
  require 'open-uri'
  
  def new
    
  end
  
  def create
    message = ""
    guest_list_xml = Nokogiri::XML(params[:guests])
    event_id = guest_list_xml.xpath('//rsveep/@eventId').text
    host = guest_list_xml.xpath('//rsveep/@host').text
    @user = User.find_by_number host
    @event = Event.find_by_eventId_and_ event_id
    
    guest_list_xml.xpath('//rsveep/guest/@number').each do |node|
      user = node.text
      if user != host
        @guest = Guest.new(:event=>@event, :user=>user)
        if !@guest.save
          message = message + user + ","
        end
      end 
    end
    if message == ""
      render(:template => "guests/success" , :formats => [:xml], :handlers => :builder, :layout => false)
    else
      message = message + " could not be added to the guest list"
      @message = message
      render(:template => "guests/failed" , :formats => [:xml], :handlers => :builder, :layout => false)
    end
  end
  
end
