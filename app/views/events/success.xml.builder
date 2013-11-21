xml.instruct!  
xml.rsveep :user => @user.number do
  xml.event {
    xml.status  :status => 'success'
    xml.eventId @event.eventId
  } 
end