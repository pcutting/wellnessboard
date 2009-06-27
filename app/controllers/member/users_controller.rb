class Member::UsersController  < Member::BaseController
  # GET /users

  # GET /users/1
  def show
    @user = @current_user

    respond_to do |format|
      format.html # show.html.erb

    end
  end


  # GET /users/1/edit
  def edit
    @user = @current_user
  end

  # POST /users
  # POST /users.xml


  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = @current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(member_root_url) }
      else
        format.html { render :action => "edit" }

      end
    end
  end


end
