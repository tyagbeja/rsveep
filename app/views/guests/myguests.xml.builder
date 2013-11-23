xml.instruct!  
xml.rsveep :eventId => @event.eventId do
  xml.guests {
    @guests.each do |guest|
      xml.guest :number=> guest.user, :response=>guest.response{
        xml.notes guest.notes
      }
    end
  }
end