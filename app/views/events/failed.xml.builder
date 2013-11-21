xml.instruct!  
xml.rsveep do
  xml.event {
    xml.status  :status => 'failed'
    xml.message @message.to_s
  } 
end