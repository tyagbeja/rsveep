xml.instruct!  
xml.rsveep :user => @user.number do
  xml.verification {
    xml.verified :status => @user.verified
  }
end