class SmsController < ApplicationController
  def send_verification
    @user = User.find_by_number params[:number]
    code = get_ver_code
 
    twilio_sid = get_twilio_sid
    twilio_token = get_twilio_token
    twilio_phone_number = get_twilio_phone_number
 
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
 
    @twilio_client.account.sms.messages.create(
      :from => "+#{twilio_phone_number}",
      :to => "+#{@user.number}",
      :body => "Welcome #{@user.name} to RSVEEP. Here is your verification code #{code}"
    )  
    
    save_or_update_ver_code @user.number, code    
    render(:template => "users/verify" , :formats => [:xml], :handlers => :builder, :layout => false)
  end
  
  private
  def get_ver_code
    rand(100000...1000000)
  end
  private
  def get_twilio_sid
    return "AC8875491683b8f91d1393cd5d21d2510a"
  end
  private
  def get_twilio_token
    return "f07d896770331c95c2a7323a2a6ce4f4"
  end
  private
  def get_twilio_phone_number
    return "441384901188"
  end
  
  private
  def save_or_update_ver_code (number_to_send_to, code)
    @verification = Verification.new(:number=>number_to_send_to, :code=> code)
    begin
      @verification.save
    rescue ActiveRecord::RecordNotUnique
      @verification = Verification.find_by :number=>number_to_send_to
      @verification.update(:code=>code)
    end
  end
end
