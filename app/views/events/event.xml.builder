xml.instruct!  
xml.rsveep :eventId => @event.eventId, :eventTitle => @event.title, :updated_at=>@event.updated_at.to_i do
  xml.event {
    xml.eventName @event.subtitle
    xml.eventType @event.type
    xml.eventDate @event.dateTime.strftime("%Y-%m-%d")
    xml.eventTime @event.dateTime.strftime("%H:%M:%S")
    xml.eventAttire @event.dressing
    xml.eventVenue @event.venue
    xml.eventAddress @event.address
    xml.eventCity @event.city
    xml.eventState @event.state
    xml.eventCountry @event.country
    xml.eventPostcode @event.postcode
    xml.latitude @event.latitude
    xml.longitude @event.longitude
    xml.note @event.notes
    xml.privacy @event.privacy
  }
  xml.eventImage @event.image
  xml.eventHost  @event.user.name ,:contactNumber=>"+#{@event.user.number}"
end

