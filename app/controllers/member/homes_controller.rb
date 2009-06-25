class Member::HomesController  < Member::BaseController

  # GET /homes
  def index
    @home = Home.new
    @recent_goal = @current_user.goals.last
    if @recent_goal.nil? then @recent_goal =  Goal.new end
    @goal = @recent_goal
    @fact = QuickFact.find(:first, :offset=>(rand(QuickFact.all.size - 1)) )
    @quick_support = QuickSupport.new
    
    @week_water_sum = @current_user.waters.sum(:ounces, :conditions => ['date >= ?', Time.now - 7.days])

    @today_water_sum = @current_user.waters.sum(:ounces, :conditions => ['date >= ?', Time.now ])
    
    @week_calories_sum = @current_user.foods.sum(:calories, :conditions => ['date >= ?', Time.now - 7.days])
    
    @today_calories_sum =@current_user.foods.sum(:calories, :conditions => ['date >= ?', Time.now])
    
    @today_water_ratio = (( @today_water_sum.to_f / @recent_goal.water ) * 100 ).to_i
    @week_water_ratio =  (( @week_water_sum.to_f / (@recent_goal.water * 7 ) ) * 100 ).to_i
    @today_calories_ratio = (( @today_calories_sum.to_f / @recent_goal.daily_calories ) * 100 ).to_i
    @week_calories_ratio = (( @week_calories_sum.to_f / (@recent_goal.daily_calories * 7 ) ) * 100 ).to_i
    
    
    
    #raise @current_user.foods.to_yaml
    @foods = @current_user.foods
    @weight = Weight.new
    @water = Water.new
    @measurement = Measurement.new
    @exercise = Exercise.new
    @body_scan = BodyScan.new
    @food = Food.new
    respond_to do |format|
      format.html # index.html.erb
    end
  end


  def create
    #@home = Home.new(params[:home])
    success = false;
    #raise params.to_yaml
    commit = params[:commit]
    
    if commit == "Add food" then
      aFood = @current_user.foods.new(params[:food])
      aFood.date = Time.now
      success = aFood.save
      
    elsif commit == "Record"
      aWeight = @current_user.weights.new(params[:weight])
      aWeight.date = Time.now
      success = aWeight.save
      #raise aWeight.to_yaml
    elsif commit == "Drank" then
      aDrink = @current_user.waters.new(params[:water])
      aDrink.date = Time.now
      success = aDrink.save
      
    elsif commit == "8oz Glass" then
      aDrink = @current_user.waters.new
      aDrink.date = Time.now
      aDrink.ounces = 8
      success = aDrink.save
      
    elsif commit == "Measurements" then
      aMeasure = @current_user.measurements.new(params[:measurement])
      aMeasure.date = Time.now
      success = aMeasure.save
    elsif commit == "Fitness" then
      aExercise = @current_user.exercises.new(params[:exercise])
      success = aExercise.save
      
    elsif commit == "Scan" then
      scan = @current_user.body_scans.new(params[:exercise])
      scan.date = Time.now
      success = scan.save
    
    elsif commit=="New Goal" then
      goal = @current_user.goals.new(params[:goal])
      success = goal.save
      
    elsif commit=="Support" then
      support = @current_user.quick_supports.new(params[:quick_support])
      success = support.save
    end
    
    respond_to do |format|
      if success then
        flash[:notice] = 'Great job!'
      else
        flash[:notice] = 'There was an error in your submission.  Please contact your coach for help.'
      end
        format.html { redirect_to( member_root_path) }
    end
  end

  # PUT /homes/1
  # PUT /homes/1.xml
  def update
  
    raise params.to_yaml
    
    #@home = Home.find(params[:id])

    respond_to do |format|
      if @home.update_attributes(params[:home])
        flash[:notice] = 'Home was successfully updated.'
        format.html { redirect_to(@home) }
      
      else
        format.html { render :action => "edit" }
 
      end
    end
  end



end
