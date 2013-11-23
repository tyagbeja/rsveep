xml.instruct!  
xml.rsveep do
  xml.sms_verification {
    xml.status  :status => 'failed'
    xml.message @message.to_s
  } 
end