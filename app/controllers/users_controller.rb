class UsersController < ApplicationController
  #New and Check method used for test will be removed later
  def new

  end
  
  def check
    
  end
  
  def create
    @user = User.new(user_params)
    begin
      @user.save
    rescue ActiveRecord::RecordNotUnique
      @user = User.find_by params[:user].permit(:number)
      @user.update(:gcmid => params[:user].permit(:gcmid).to_s)
    end
    redirect_to sms_path(:number=>@user.number, :name=>@user.name)
  end
  
  def verify
    @verification = Verification.find_by_number (params[:number])
    @user = User.find_by_number params[:number]
    
    unless @verification.nil? || @verification.code != params[:code]      
      @user.update(:verified => true )
      render(:template => "users/verify" , :formats => [:xml], :handlers => :builder, :layout => false)
    else
      @user.update(:verified => false )
      redirect_to sms_path(:number=>@user.number)
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :number, :gcmid)
  end
end
