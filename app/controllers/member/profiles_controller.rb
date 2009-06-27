class Member::ProfilesController  < Member::BaseController
  # GET /profiles
  # GET /profiles.xml


  # GET /profiles/1
  def show
    @profile = @current_user.profile

    respond_to do |format|
      format.html # show.html.erb
    end
  end


  def edit
    @profile = @current_user.profile
  end


  def update

    @profile = @current_user.profile

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        flash[:notice] = 'Profile was successfully updated.'       
        format.html { redirect_to(edit_member_profile_url) }
      else
        format.html { render :action => "edit" }
      end
    end
  end



end
