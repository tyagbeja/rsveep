xml.instruct!  
xml.rsveep :user => @user.number do
  xml.eventId @event.eventId
  xml.guest {
    xml.status  :status => 'success'
  }
  if @sms == 'phone'
    xml.sms_guests {
      @non_rsveep_users.each do |user|
        xml.sms_guest user
      end
    }
  end
end

