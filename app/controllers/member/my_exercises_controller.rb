class Member::MyExercisesController  < Member::BaseController
  # GET /my_exercises
  # GET /my_exercises.xml
  def index
    @my_exercises = MyExercise.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @my_exercises }
    end
  end

  # GET /my_exercises/1
  # GET /my_exercises/1.xml
  def show
    @my_exercise = MyExercise.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @my_exercise }
    end
  end

  # GET /my_exercises/new
  # GET /my_exercises/new.xml
  def new
    @my_exercise = MyExercise.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @my_exercise }
    end
  end

  # GET /my_exercises/1/edit
  def edit
    @my_exercise = MyExercise.find(params[:id])
  end

  # POST /my_exercises
  # POST /my_exercises.xml
  def create
    @my_exercise = MyExercise.new(params[:my_exercise])

    respond_to do |format|
      if @my_exercise.save
        flash[:notice] = 'MyExercise was successfully created.'
        format.html { redirect_to(@my_exercise) }
        format.xml  { render :xml => @my_exercise, :status => :created, :location => @my_exercise }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @my_exercise.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /my_exercises/1
  # PUT /my_exercises/1.xml
  def update
    @my_exercise = MyExercise.find(params[:id])

    respond_to do |format|
      if @my_exercise.update_attributes(params[:my_exercise])
        flash[:notice] = 'MyExercise was successfully updated.'
        format.html { redirect_to(@my_exercise) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @my_exercise.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /my_exercises/1
  # DELETE /my_exercises/1.xml
  def destroy
    @my_exercise = MyExercise.find(params[:id])
    @my_exercise.destroy

    respond_to do |format|
      format.html { redirect_to(my_exercises_url) }
      format.xml  { head :ok }
    end
  end
end
