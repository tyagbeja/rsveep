xml.instruct!  
xml.rsveep :user => @user.number do
  xml.eventId @event.eventId
  xml.guest {
    xml.status  :status => 'Response update successful'
  }
  xml.response @response
  
end

