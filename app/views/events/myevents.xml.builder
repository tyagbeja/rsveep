xml.instruct!  
xml.rsveeps do
  @events.each do |event|
    xml.rsveep :eventId => event.eventId, :eventTitle => event.title, :updated_at=>event.updated_at.to_i do
      xml.event {
        xml.eventName event.subtitle
        xml.eventType event.type
        xml.eventDate event.dateTime.strftime("%Y-%m-%d")
        xml.eventTime event.dateTime.strftime("%H:%M:%S")
        xml.eventAttire event.dressing
        xml.eventVenue event.venue
        xml.eventAddress event.address
        xml.eventCity event.city
        xml.eventState event.state
        xml.eventCountry event.country
        xml.eventPostcode event.postcode
        xml.latitude event.latitude
        xml.longitude event.longitude
        xml.note event.notes
        xml.privacy event.privacy
      }
      xml.eventImage event.image
      xml.eventHost  event.user.name ,:contactNumber=>"+#{event.user.number}"
      xml.eventStatus event.status
      xml.guests {
        event.guest.each do |guest|
          xml.guest :number=> guest.user, :response=>guest.response{
            xml.notes guest.notes
          }
        end
      } 
    end
  end
end

