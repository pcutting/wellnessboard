class UsersController < ApplicationController
  # GET /users
  def index

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /users/1
  def show
    #@user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb

    end
  end

  # GET /users/new
  def new
    if @user_session then @user_session.destroy end
    @user = User.new
    @profile = Profile.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /users/1/edit
  def edit
    @user = current_user
  end

  # POST /users
  # POST /users.xml
  def create
    #Logout first if there is a previous session open.
    if @user_session then @user_session.destroy end
    
    @user = User.new(params[:user])
    @profile = Profile.new(params[:profile])

    
    
    if (!(@profile.hight_feet.nil? && @profile.hight_inches.nil? )  && !@profile.dob.nil?) then
      success = @user.save
      flash[:notice] = "Please make sure you enter your hight and Date of Birth."
    else 
      success = false
    end
    
    if (success) then
      success = @profile.save
      @user.profile = @profile
      @user.profile.save
      
        
       
      @home = Home.new
      @home.chart_type = 'all'
      @user.home = @home 
      @user.home.save
      
      
      
      
      
      aWeight = @user.weights.new(params[:weight])
      success = aWeight.save
      
      #raise aWeight.to_yaml
      
      
      goal = @user.goals.new(params[:goal])
      success = goal.save
      
      
    end

    respond_to do |format|
      if success
        flash[:notice] = 'Registration successful.'
        format.html { redirect_to(home_url) }

      else
        format.html { render :action => "new" }

      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Password successfully updated.'
        format.html { redirect_to(home_url) }
      else
        format.html { render :action => "edit" }

      end
    end
  end


end
