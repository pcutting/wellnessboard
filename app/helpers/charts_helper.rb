module ChartsHelper
  class Calendar 
    
    attr_accessor :events
    
    def initialize
      @events = Array.new
    end
  end
  
  class Event
  
    @date
    @label
    @summary 
    @type

    attr_reader :date, :label, :summary, :type 
    attr_writer  :label, :summary, :type
    
    def date 
      @date.to_date
    end
    
    def initialize
      
    end
    
    def initialize(date,label,summary,type)
      @date = date.to_date
      @label = label
      @summary = summary
      @type = type
    end
    
    def to_s
      "#{@label}: #{@date} <br/>#{@summary}"
    end
  end

  class Point
    attr_accessor :x, :y
    
    def initialize(x,y)
      @x = x
      @y = y
    end #initialize
  
    def to_s
      "#{x}, #{y}"
    end

  end #end point

  class ChartItem
    
    attr_accessor :points, :showPoints, :showLine
    attr_writer :label
    
    def initialize (label)
      @points = Array.new
      @label = label
      @showPoints = true
      @showLines = true
    end #initialize
    
    def addPoint(x,y)
      @points.push(Point.new(x,y))
    end
    
    def size
      @points.size
    end
      
    def displayLabel
      "label:'#{@label}',data: [], points: {show:false}, lines:{show:false}"
    end
    
    def to_s
      "label:'#{@label}'\n#{getAllPoints}"
    end
    
    def getAllPoints
      string = ""
      for point in @points
        if string == "" then  string += "[#{point.to_s}]" 
        else string += ",[#{point.to_s}]" 
        end 
      end
      string  
    end

    def to_chart
      "label:'#{@label}', data:[#{getAllPoints}], points: {show:#{@showPoints}}, lines:{show:#{@showLines}}"
    end
    
  end #ChartItems

  class Chartable
    # may not be needed if i just make an array of chartItems.
    attr_accessor :datasets
    def initialize 
      @datasets = Array.new
    end
    
    def showLabel
      string = ""
      for sample in @datasets
        if string == "" then 
          string += "{#{sample.displayLabel}}"
        else 
          string += ",{#{sample.displayLabel}}"
        end
      end
      string
    end
    
   def to_chart
      string = ""
      for sample in @datasets
        if string == "" then 
          string += "{#{sample.to_chart}}"
        else 
          string += ",{#{sample.to_chart}}"
        end
      end
      string
    end
    
    def add(set)
      @datasets.push(set)
    end
  end #chartables

####################
# Use template system.
# make a chart
# return html string
#
####################

def makeChart(*options)

display = "
<div class='charts last'>

<div class='left'>


<div id='placeholder' style='width:400px;height:200px;'></div>
<div id='overview' style='width:400px;height:50px'></div>
<p id='overviewLegend' style='margin-left:10px'></p>

<p> Try zooming. Click and drag to select a zone.</p>
</div>

<div class='right'>

Weight Chart<br/>
<div id='miniWeight' style='width:350px;height:100px;'></div>
Water Chart<br/>
<div id='miniWater' style='width:350px;height:100px;'></div>


Calories Eaten<br/>
<div id='miniCalorie' style='width:350px;height:100px;'></div>
Fitness (Calories burned not to include resting metabolism)<br/>
<div id='miniFitness' style='width:350px;height:100px;'></div><br/>

Measurements (Total inches)<br/>
<div id='miniMeasures' style='width:350px;height:100px;'></div>


</div>




<div class='last'></div>
<script id='source' language='javascript' type='text/javascript'>


$(function () {
var options = {
  xaxis: { mode: 'time' },
  selection: { mode: 'x' },
  legend: { 
    show: true, 
    container: $('#overviewLegend'),
    noColumns: 2,
  }
};

var options_overview = {
  xaxis: { mode: 'time' },
  selection: { mode: 'x' },
  legend: { show: false}
};


var plot = $.plot($('#placeholder'), 
[  #{@chartable.to_chart } ], options);




var overview = $.plot($('#overview'), 
[  #{@chartable.to_chart}], 
{ lines: { show: true, lineWidth: 3 },
  shadowSize: 0,
  legend: {
    show: false },
    xaxis: { ticks: 3, mode: 'time' },
    selection: { mode: 'x' }
});






var overview_1 = $.plot($('#miniWeight'), 
[  #{@miniWeight.to_chart}], 
{ lines: { show: true, lineWidth: 3 },
  shadowSize: 0,
  legend: {
    show: false },
    xaxis: { ticks: 3, mode: 'time' },
    selection: { mode: 'x' }
});


var overview_2 = $.plot($('#miniWater'), 
[  #{@miniWater.to_chart}], 
{ lines: { show: true, lineWidth: 3 },
  shadowSize: 0,
  legend: {
    show: false },
    xaxis: { ticks: 3, mode: 'time' },
    selection: { mode: 'x' }
});


var overview_3 = $.plot($('#miniCalorie'), 
[  #{@miniCalorie.to_chart}], 
{ lines: { show: true, lineWidth: 3 },
  shadowSize: 0,
  legend: {
    show: false },
    xaxis: { ticks: 3, mode: 'time' },
    selection: { mode: 'x' }
});


var overview_4 = $.plot($('#miniFitness'), 
[  #{@miniFitness.to_chart}], 
{ lines: { show: true, lineWidth: 3 },
  shadowSize: 0,
  legend: {
    show: false },
    xaxis: { ticks: 3, mode: 'time' },
    selection: { mode: 'x' }
});


var overview_5 = $.plot($('#miniMeasures'), 
[  #{@miniMeasures.to_chart}], 
{ lines: { show: true, lineWidth: 3 },
  shadowSize: 0,
  legend: {
    show: false },
    xaxis: { ticks: 3, mode: 'time' },
    selection: { mode: 'x' }
});


// now connect the two
var internalSelection = false;

$('#placeholder').bind('selected', function (event, area) {
  // do the zooming
  plot = $.plot($('#placeholder'),   
  [#{@chartable.to_chart}],
                $.extend(true, {}, options, {
                    xaxis: { min: area.x1, max: area.x2 }
                }));
  
  if (internalSelection)
      return; // prevent eternal loop
  internalSelection = true;
  overview.setSelection(area);
  internalSelection = false;
});

$('#overview').bind('selected', function (event, area) {
  if (internalSelection)
      return;
  internalSelection = true;
  plot.setSelection(area);
  internalSelection = false;
});


});
</script>
"

end #def makeCharts(options)


##################
# myPlots
##################


def myPlots(options='all')

#raise options.inspect
#pass "all" or specific option

@chartable = Chartable.new
@miniWeight = Chartable.new
@miniWater = Chartable.new
@miniCalorie = Chartable.new
@miniFitness = Chartable.new
@miniMeasures = Chartable.new




#if it's a specific option then go with it, otherwise show 
#  all components of that model that are chartable.
#if options == "all" 
  @chartoptions=Hash[
     :measurement=>[true,true,true],
     :weight=>[true,true,true],
     :body_scan=>[true,true,true],
     :food=>[true, true, true],
     :water=>[true,true,true],
     :exercise=>[true, true,true],
     :measurement_chest=>[true,true,true],
     :measurement_arm=>[true,true,true],
     :measurement_upper_belly=>[true,true,true],
     :measurement_hip=>[true,true,true],
     :measurement_thigh=>[true,true,true],
     ]
     #raise @chartoptions.to_yaml
#end


  
  @water = @current_user.waters.find(:all, :order => "date asc") 
  if options == "all" || options == "water"  
    getWater unless @water.nil? || @water.size == 0 #function call
  end

  
  @food =@current_user.foods.find(:all, :order => "date asc") 
  if options == "all" || options == "food"
    getFood  unless @food.nil?  || @food.size == 0  #function call
  end

  
  @exercise =@current_user.exercises.find(:all, :order => "date asc")
  if options == "all" || options == "exercise"
    getExercise unless @exercise.nil?  || @exercise.size == 0 #function call
  end
  
  @measurement =@current_user.measurements.find(:all, :order => "date asc" ) 
  if options == "all" || options == "measurement" 
    getMeasurement unless @measurement.nil?  || @measurement.size == 0 #function call
  end

  @weight = @current_user.weights.find(:all, :order => "date asc") 
  if options == "all" || options == "weight" 
    getWeight unless @weight.nil? || @weight.size == 0  #function call
  end



  getMiniWater
  getMiniFood
  getMiniExercise
  getMiniWeight
  getMiniMeasurement


end # ends myPlots
  
  
###########################
# build function to get 
# the min and max Y ranges 
# for the chart.
###########################  
def check_min_max

end
  
  
  
  
#####################
# Gets Water
#####################
  
def getWater
  #Water
  
  oldDate = nil
  
  if ( @chartoptions[:water][0])
    
    @set1 = ChartItem.new("Ounces Water")   

    for water in @water
      if oldDate.nil?
        daily_water_sum = water.ounces
        oldDate = water.date.to_date
        @set1.addPoint(water.date.to_time.to_i * 1000,  daily_water_sum)
      elsif oldDate != water.date.to_date
        @set1.addPoint(water.date.to_time.to_i * 1000,  daily_water_sum)
        daily_water_sum = water.ounces
        oldDate = water.date.to_date
      else #must be same date as previous record (records should be ordered)
        daily_water_sum += water.ounces
        @set1.addPoint(water.date.to_time.to_i * 1000,  daily_water_sum)
      end
    end 
    
    #Make last post to chart
    if oldDate != water.date.to_date then
      daily_water_sum += water.ounces
      @set1.addPoint(water.date.to_time.to_i * 1000,  daily_water_sum)
    end
     
      
    if @chartoptions[:water][0]
    @chartable.add(@set1)
    end 
  end 
end 
    
  
  
####################
#gets Food
####################
def getFood

  if ( @chartoptions[:food][0])  
    oldDate = nil  
    @set1 = ChartItem.new("Daily Calories")   
    for food in @food
      if oldDate.nil?
        daily_calories_sum = food.calories
        oldDate = food.date.to_date
        @set1.addPoint(food.date.to_time.to_i * 1000,  daily_calories_sum)
      elsif oldDate != food.date.to_date
        @set1.addPoint(food.date.to_time.to_i * 1000,  daily_calories_sum)
        daily_calories_sum = food.calories
        oldDate = food.date.to_date
      else #must be same date as previous record (records should be ordered)
        daily_calories_sum += food.calories
        @set1.addPoint(food.date.to_time.to_i * 1000,  daily_calories_sum)
      end
    end    
    #Make last post to chart
    if oldDate != food.date.to_date then
      daily_calories_sum += food.calories
      @set1.addPoint(food.date.to_time.to_i * 1000,  daily_calories_sum)
    end
    
    if @chartoptions[:food][0]
      @chartable.add(@set1)
    end 
  end

end #def getFood
  
  
  
#####################
# Gets Exercise
#####################
  
def getExercise

##############################################

  if ( @chartoptions[:exercise][0])  
    oldDate = nil  
    daily_calories_sum = 0
    @set1 = ChartItem.new("Calories Burnt(Fitness)")   
    for exercises in @exercise
      if oldDate.nil?
        daily_calories_sum = exercises.calories
        oldDate = exercises.date.to_date
        @set1.addPoint(exercises.date.to_time.to_i * 1000,  daily_calories_sum)
      elsif oldDate != exercises.date.to_date
        @set1.addPoint(exercises.date.to_time.to_i * 1000,  daily_calories_sum)
        daily_calories_sum = exercises.calories
        oldDate = exercises.date.to_date
      else #must be same date as previous record (records should be ordered)
        daily_calories_sum += exercises.calories
        @set1.addPoint(exercises.date.to_time.to_i * 1000,  daily_calories_sum)
      end
    end    
    if oldDate != exercises.date.to_date then
      daily_calories_sum += exercises.calories
      @set1.addPoint(exercises.date.to_time.to_i * 1000,  daily_calories_sum)
    end   
    if @chartoptions[:exercise][0]
      @chartable.add(@set1)
    end 
  end
###############################################
 # if ( @chartoptions[:exercise][0]|| @chartoptions[:exercise][1])  
 #   @setExercise = ChartItem.new("Calories Burnt")     
 #   for exercises in @exercise
 #     count += 1  
 #     @setExercise.addPoint(exercises.date.to_i * 1000,exercises.calories)  
 #   end  
       
 #   if @chartoptions[:exercise][0]      
 #     @chartable.add(@setExercise)
   
 #   end 
 
 # end #@options[:exercise] 
end # def getExercise
  
  
#################
#Weight
#################  
  
def getWeight

 #raise @chartoptions.to_yaml
 
 
if ( @chartoptions[:weight][0] )

    @set1 = ChartItem.new("Weight")

 
  for weights in @weight

    @set1.addPoint(weights.date.to_i * 1000,weights.weight)
 
  end 
  
  if @chartoptions[:weight][0]
    @chartable.add(@set1)
  end 

end # weight 
end #def getweight
  
  
##################
# Get measurements
##################

def getMeasurement
#measurements
#TODO check that this needs to be called, currently it always calls it.
#if @chartoptions[:measurement][0] || @chartoptions[:measurement][1] || @chartoptions[:measurement][2]


    @set5 = ChartItem.new("Measurement:Chest")

    @set6 = ChartItem.new("Measurement:Upper Belly")

    @set7 = ChartItem.new("Measurement:Hip")
 
    @set8 = ChartItem.new("Measurement:Thigh")

    @set10 = ChartItem.new("Measurement:Arm")

 
    
    
    
  meas1, meas2, meas3, meas4, meas5, meas6, meas7, meas8, meas9, meas10, meas11, meas12, meas13 = [],[],[],[],[],[],[],[],[],[],[],[],[]
  
  meas1_avg, meas2_avg, meas3_avg, meas4_avg, meas5_avg, meas6_avg, meas7_avg, meas8_avg, meas9_avg, meas10_avg, meas11_avg, meas12_avg, meas13_avg = [],[],[],[],[],[],[],[],[],[],[],[],[]
  
   
  meas1_count, meas2_count, meas3_count, meas4_count, meas5_count, meas6_count, meas7_count, meas8_count, meas9_count, meas10_count, meas11_count, meas12_count, meas13_count = 0,0,0,0,0,0,0,0 ,0,0,0,0,0
  
  meas1_sum, meas2_sum, meas3_sum, meas4_sum, meas5_sum, meas6_sum, meas7_sum, meas8_sum , meas9_sum, meas10_sum, meas11_sum, meas12_sum, meas13_sum = 0,0,0,0,0,0,0,0,0,0,0,0,0 
  
  for measurement in @measurement
    
    
    if !(measurement.chest.nil? )  &&  ( @chartoptions[:measurement_chest][0] || @chartoptions[:measurement_chest][1]   || @chartoptions[:measurement][0] || @chartoptions[:measurement][1]) 
      meas6_count += 1 
      meas6_sum += measurement.chest  
      @set5.addPoint(measurement.date.to_time.to_i * 1000,measurement.chest)
   
    end 
    
    if !(measurement.belly_upper.nil? ) &&  ( @chartoptions[:measurement_upper_belly][0]) 
      @set6.addPoint(measurement.date.to_time.to_i * 1000, measurement.belly_upper)
    end 
    
    if !(measurement.hips.nil? )  &&  (@chartoptions[:measurement_hip][0] ) 
   
      @set7.addPoint(measurement.date.to_time.to_i * 1000,measurement.hips)
 
    end 
    

    if @chartoptions[:measurement_thigh][0]
      @set8.addPoint(measurement.date.to_time.to_i * 1000,measurement.thigh)
    end     
    

    
    if !(measurement.arm.nil? && measurement.arm == 0 )  &&  (@chartoptions[:measurement_arm][0]) 

      @set10.addPoint(measurement.date.to_time.to_i * 1000,measurement.arm)

    end      

 
    
  end 
#  ----------------------------------
#  now start adding them to the chart
#  ----------------------------------    
  #if @chartoptions[:measurement][0]
 
    if (@chartoptions[:measurement_chest][0] || @chartoptions[:measurement][0] )
     @chartable.add(@set5)
    end 
    if (@chartoptions[:measurement_upper_belly][0] || @chartoptions[:measurement][0] )
      @chartable.add(@set6) 
    end 
    if (@chartoptions[:measurement_hip][0] || @chartoptions[:measurement][0] )
      @chartable.add(@set7)
    end 

    if (@chartoptions[:measurement_thigh][0] || @chartoptions[:measurement][0] )
      @chartable.add(@set8)
    end 

    if (@chartoptions[:measurement_arm][0] || @chartoptions[:measurement][0] )
      @chartable.add(@set10)
    end 
    

#end # if @chartoptions[:measurments] 
end #def getMeasurements




############################
# Mini charts
############################

  
  
#####################
# getMinis Water
#####################
  
def getMiniWater
  #Water
  
  oldDate = nil
  
  if ( @chartoptions[:water][0])
    
    @set1 = ChartItem.new("Ounces Water")   

    for water in @water
      if oldDate.nil?
        daily_water_sum = water.ounces
        oldDate = water.date.to_date
        @set1.addPoint(water.date.to_time.to_i * 1000,  daily_water_sum)
      elsif oldDate != water.date.to_date
        @set1.addPoint(water.date.to_time.to_i * 1000,  daily_water_sum)
        daily_water_sum = water.ounces
        oldDate = water.date.to_date
      else #must be same date as previous record (records should be ordered)
        daily_water_sum += water.ounces
        @set1.addPoint(water.date.to_time.to_i * 1000,  daily_water_sum)
      end
    end 
    
    #Make last post to chart
    if oldDate != water.date.to_date then
      daily_water_sum += water.ounces
      @set1.addPoint(water.date.to_time.to_i * 1000,  daily_water_sum)
    end
     
      
    if @chartoptions[:water][0]
    @miniWater.add(@set1)
    end 
  end 
end 
    
  
  
####################
#gets Food
####################
def getMiniFood

  if ( @chartoptions[:food][0])  
    oldDate = nil  
    @set1 = ChartItem.new("Daily Calories")   
    for food in @food
      if oldDate.nil?
        daily_calories_sum = food.calories
        oldDate = food.date.to_date
        @set1.addPoint(food.date.to_time.to_i * 1000,  daily_calories_sum)
      elsif oldDate != food.date.to_date
        @set1.addPoint(food.date.to_time.to_i * 1000,  daily_calories_sum)
        daily_calories_sum = food.calories
        oldDate = food.date.to_date
      else #must be same date as previous record (records should be ordered)
        daily_calories_sum += food.calories
        @set1.addPoint(food.date.to_time.to_i * 1000,  daily_calories_sum)
      end
    end    
    #Make last post to chart
    if oldDate != food.date.to_date then
      daily_calories_sum += food.calories
      @set1.addPoint(food.date.to_time.to_i * 1000,  daily_calories_sum)
    end
    
    if @chartoptions[:food][0]
      @miniCalorie.add(@set1)
    end 
  end

end #def getMiniFood
  
  
  
#####################
# getMinis Exercise
#####################
  
def getMiniExercise

##############################################

  if ( @chartoptions[:exercise][0] && !@exercise.nil?)  
    oldDate = nil  
    daily_calories_sum = 0
    @set1 = ChartItem.new("Calories Burnt(Fitness)")   
    for exercises in @exercise
      if oldDate.nil?
        daily_calories_sum = exercises.calories
        oldDate = exercises.date.to_date
        @set1.addPoint(exercises.date.to_time.to_i * 1000,  daily_calories_sum)
      elsif oldDate != exercises.date.to_date
        @set1.addPoint(exercises.date.to_time.to_i * 1000,  daily_calories_sum)
        daily_calories_sum = exercises.calories
        oldDate = exercises.date.to_date
      else #must be same date as previous record (records should be ordered)
        daily_calories_sum += exercises.calories
        @set1.addPoint(exercises.date.to_time.to_i * 1000,  daily_calories_sum)
      end
    end    
    if oldDate != exercises.date.to_date then
      daily_calories_sum += exercises.calories
      @set1.addPoint(exercises.date.to_time.to_i * 1000,  daily_calories_sum)
    end   
    if @chartoptions[:exercise][0]
      @miniFitness.add(@set1)
    end 
  end
###############################################
 # if ( @chartoptions[:exercise][0]|| @chartoptions[:exercise][1])  
 #   @setExercise = ChartItem.new("Calories Burnt")     
 #   for exercises in @exercise
 #     count += 1  
 #     @setExercise.addPoint(exercises.date.to_i * 1000,exercises.calories)  
 #   end  
       
 #   if @chartoptions[:exercise][0]      
 #     @chartable.add(@setExercise)
   
 #   end 
 
 # end #@options[:exercise] 
end # def getMiniExercise
  
  
#################
#Weight
#################  
  
def getMiniWeight

 #raise @chartoptions.to_yaml
 
 
if ( @chartoptions[:weight][0]  &&  ! @weight.nil?)

    @set1 = ChartItem.new("Weight")

 
  for weights in @weight

    @set1.addPoint(weights.date.to_i * 1000,weights.weight)
 
  end 
  
  if @chartoptions[:weight][0]
    @miniWeight.add(@set1)
  end 

end # weight 
end #def getMiniweight
  
  
##################
# getMini measurements
##################

def getMiniMeasurement
#measurements


   @set= ChartItem.new("Total Inches")

  for measurement in @measurement
    
   # id: integer, user_id: integer, chest: integer, belly_upper: integer, belly_lower: integer, hips: integer, thigh: integer, arm: integer, date: datetime, created_at: datetime, updated_at: datetime
    sum = measurement.chest + measurement.belly_upper + measurement.belly_lower + measurement.hips + measurement.thigh + measurement.arm
    
    @set.addPoint(measurement.date.to_time.to_i * 1000,sum)
    
  end 
#  ----------------------------------
#  now start adding them to the chart
#  ----------------------------------    
  #if @chartoptions[:measurement][0]
 
 
     @miniMeasures.add(@set)


#end # if @chartoptions[:measurments] 
end #def getMiniMeasurements




 
end # ends helper

