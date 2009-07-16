class UserSessionsController < ApplicationController

  def new
    @user_session = UserSession.new
    @testimony = Testimony.find(:first,  :offset=>(rand(Testimony.all.size - 1)) )

    
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Successfully logged in."
      redirect_to home_url
    else
      render :action => 'new'
    end
    
  end
  
  
  def destroy
     @user_session = UserSession.find
     @user_session.destroy
     flash[:notice] = "Successfully logged out."
     redirect_to root_url
  end

  
end
