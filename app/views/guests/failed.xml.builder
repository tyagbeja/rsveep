xml.instruct!  
xml.rsveep do
  xml.guest {
    xml.status  :status => 'failed'
    xml.message @message.to_s
  } 
  xml.reg_ids "#{@user.number} / #{@count}"
end