class HomesController  < BaseController

  # GET /homes
  def show
  
    @profile = @current_user.profile
    
    
    #raise @current_user.inspect
    
    @home = @current_user.home
    @recent_goal = @current_user.goals.last
    if @recent_goal.nil? then @recent_goal =  Goal.new end
    @goal = @recent_goal
    @fact = QuickFact.find(:first, :offset=>(rand(QuickFact.all.size - 1)) )
    if @fact.nil? then 
      @fact = QuickFact.new
      @fact.title = "Blank"
      @fact.category = "Test"
      @fact.summary = "Please submit interesting facts"
    end
    
    if @home.nil? then
      @chart_type = 'all'
    else
      @chart_type = @home.chart_type 
    end
    
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
    
    elsif commit=='Herbal Tea 8oz' then
      aDrink = @current_user.waters.new
      aDrink.date = Time.now
      aDrink.ounces = 8
      success = aDrink.save
      
      aExercise = @current_user.exercises.new
      aExercise.title = "Drink and Shrink"
      aExercise.calories = 80
      aExercise.length = 1
      aExercise.date = Time.now
      success = aExercise.save
      
      aFood = @current_user.foods.new
      aFood.name = "Herbal Tea Concentrate"
      aFood.calories = 5
      aFood.date = Time.now
      success = aFood.save

    
    elsif commit == "Wine" then
      aDrink = @current_user.waters.new
      aDrink.date = Time.now
      aDrink.ounces = (-2)
      success = aDrink.save
      
      aExercise = @current_user.exercises.new
      aExercise.title = "Alcohol slows metabolism"
      aExercise.calories = (-20)
      aExercise.length = 1
      aExercise.date = Time.now
      success = aExercise.save
      
      aFood = @current_user.foods.new
      aFood.name = "Wine"
      aFood.calories = 119
      aFood.protein = 0.5
      aFood.date = Time.now
      success = aFood.save
    
    elsif commit == "Beer" then
      aDrink = @current_user.waters.new
      aDrink.date = Time.now
      aDrink.ounces = (-6)
      success = aDrink.save
      
      aExercise = @current_user.exercises.new
      aExercise.title = "Alcohol slows metabolism"
      aExercise.calories = (-80)
      aExercise.length = 1
      aExercise.date = Time.now
      success = aExercise.save
      
      aFood = @current_user.foods.new
      aFood.name = "Beer"
      aFood.calories = 180
      aFood.protein = 2
      aFood.date = Time.now
      success = aFood.save

    elsif commit == "Coffee 6oz" then
      aDrink = @current_user.waters.new
      aDrink.date = Time.now
      aDrink.ounces = -4
      success = aDrink.save
      
      aFood = @current_user.foods.new
      aFood.name = "Coffee w/o cream and sugar"
      aFood.calories = 2
      aFood.protein = 0
      aFood.date = Time.now
      success = aFood.save
            
      
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
      
      
    elsif commit=="All Charts" then
      @current_user.home.chart_type = 'all' 
      success =  @current_user.home.save   
      
    elsif commit=="Water" then     
      @current_user.home.chart_type = 'water' 
      success =  @current_user.home.save
      
    elsif commit=="Exercise" then
      @current_user.home.chart_type = 'exercise' 
      success =  @current_user.home.save
      
    elsif commit=="Weight" then
      @current_user.home.chart_type = 'weight' 
      success =  @current_user.home.save
      
    elsif commit=="Food" then
      @current_user.home.chart_type = 'food' 
      success =  @current_user.home.save     
      
    elsif commit=="Measurements" then 
      @current_user.home.chart_type = 'measurement' 
      success =  @current_user.home.save
      
    end
    
    
    
    respond_to do |format|
      if success then
        #flash[:notice] = 'Great job!'
      else
        flash[:error] = 'There was an error in your submission.  Please contact your coach for help.'
      end
        format.html { redirect_to( home_path) }
    end
  end



end
