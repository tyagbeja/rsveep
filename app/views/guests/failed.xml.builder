xml.instruct!  
xml.rsveep do
  xml.guest {
    xml.status  :status => 'failed'
    xml.message @message.to_s
  }
  if @sms == 'phone'
    xml.sms_guests {
      @non_rsveep_users.each do |user|
        xml.sms_guest user
      end
    }
  end
end