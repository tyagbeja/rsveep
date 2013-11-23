xml.instruct!  
xml.rsveep :user => @user.number do
  xml.events {
    @guests.each do |guest|
      xml.event :eventId=> guest.event.eventId
    end
  }
end