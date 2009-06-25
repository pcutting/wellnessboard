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
<div id='overview' style='width:600px;height:50px'></div>
<p> Try zooming. Click and drag to select a zone.</p>

<div id='placeholder' style='width:600px;height:200px;'></div>

</div>


<div id='legendholder' class='right' style='width:200px;height:1px;'></div>


<div class='last'></div>
<script id='source' language='javascript' type='text/javascript'>


$(function () {
var options = {
  xaxis: { mode: 'time' },
  selection: { mode: 'x' },
  legend: { show: false}
};

var options_overview = {
  xaxis: { mode: 'time' },
  selection: { mode: 'x' },
  legend: { show: false}
};

var options_legend = {
  xaxis: { mode: 'time' },
  selection: { mode: 'x' },
  legend: {
      show: true,
      //labelFormatter: null,
      //labelBoxBorderColor: color,
      noColumns:2,
      position: 'ne'  
      // 'ne' or 'nw' or 'se' or 'sw'
      //margin: number of pixels
      //backgroundColor: null or color
      //backgroundOpacity: number in 0.0 - 1.0
      //container: null // or jQuery object
}
};

var plot = $.plot($('#placeholder'), 
[  #{@chartable.to_chart } ], options);


var legendplot = $.plot($('#legendholder'), 
[  #{@chartable.showLabel} ],
{ lines: { show: false },
  shadowSize: 0,
  legend: {
      show: true,
      position: 'ne'
       },
  xaxis: { ticks: 0, mode: 'time' },
  yaxis: { ticks: 0}
  }
);

var overview = $.plot($('#overview'), 
[  #{@chartable.to_chart}], 
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
#pass "all" or specific option

@chartable = Chartable.new



#if it's a specific option then go with it, otherwise show 
#  all components of that model that are chartable.
if options == "all" 
  @chartoptions=Hash[
     :measurement=>[true,true,true],
     :weight=>[true,true,true],
     :body_scan=>[true,true,true],
     :food=>[true, true, true],
     :water=>[true,true,true],
     :measurement_chest=>[true,true,true],
     :measurement_arm=>[true,true,true],
     :measurement_upper_belly=>[true,true,true],
     :measurement_hip=>[true,true,true],
     :measurement_thigh=>[true,true,true],
     ]
     #raise @chartoptions.to_yaml
   else
   #@chartoptions =@current_user.profile.myChartOptions
   # raise @chartoptions.to_yaml  
end


  if options == "all" || options == "water"
    @water = @current_user.waters.find(:all, :order => "date asc") 
    getWater unless @water.nil? || @water.size == 0 #function call
  end

  if options == "all" || options == "food"
    @food =@current_user.foods.find(:all, :order => "date asc") 
    getFood  unless @food.nil?  || @food.size == 0  #function call
  end

  if options == "all" || options == "exercise"
    @exercise =@current_user.exercises.find(:all, :order => "date asc")
    getExercise unless @exercise.nil?  || @exercise.size == 0 #function call
  end

  if options == "all" || options == "measurement" 
    @measurement =@current_user.measurements.find(:all, :order => "date asc" ) 
    getMeasurement unless @measurement.nil?  || @measurement.size == 0 #function call
  end

  if options == "all" || options == "weight" 
    @weight = @current_user.weights.find(:all, :order => "date asc") 
    getWeight unless @weight.nil? || @weight.size == 0  #function call
  end

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

  exercise1, exercise2 , exercise1_avg , exercise2_avg = [], [], [], []  
  sum_exercise1, sum_exercise2 , count = 0,0,0 
  if ( @chartoptions[:exercise][0]|| @chartoptions[:exercise][1]) 
  
    @setExercise = ChartItem.new("Calories Burnt")
     
      
    for exercises in chart_exercises
      count += 1 
      
      @setExcercise.addPoint(exercises.date.to_i * 1000,exercises.calories)
     
      
    
    end  
       
    if @chartoptions[:exercise][0]      
      @chartable.add(@setExercise)
   
    end 
 
  end #@options[:exercise] 
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

###########################################
# table generation.
###########################################

def make_table

  i = 0
  column = 0
  width = 850
  max_column = 10
  cell_width = width/ max_column

  #medical      #t.date :approx_date      #t.string :hospital      #t.string :problem      #t.string :treatment      #t.string :doctor      #t.string :city      #t.string :state      #t.string :dr_phone      #t.boolean :required_hospitalization
  #illness      #t.string :title      #t.boolean :has      #t.boolean :controlled      #t.boolean :at_risk      #t.boolean :in_family_history      #t.boolean :concerned_about      #t.string :comment
  
  @calendar = Calendar.new
  counter = 0

  unless @medical_histories.nil?
    
    for med in @medical_histories
      counter += 1
      @calendar.events.push(Event.new(med.approx_date.to_date, "H#{counter}<br/>#{med.approx_date.to_date.to_s(:short)}" , "<em>Dr Name:</em>#{med.doctor} <em>Hospital:</em>#{med.hospital},<br/><em>Purpose:</em>#{med.problem}, <em>Hospitalization:</em>#{if med.required_hospitalization then 'Yes' else 'No' end}","H"))
    end
  end
  
  unless @illness.nil?
    counter = 0
    for ill in @illness
      counter += 1
      #i need to add a date field for this.
      @calendar.events.push(Event.new(ill.date.to_date, "I#{counter}<br/>#{ill.date.to_date.to_s(:short)}", "Condition:#{ill.title}, Controlled:#{if ill.controlled then 'Yes' else 'No' end}", "I"))
    end
  end
  
  @calendar.events.sort! { |a,b| a.date <=> b.date }
  
  #if @calendar.events.size > 1 then
  #  @calendar.events.sort! { |a,b| a.date <=> b.date } 
  #end 
  
  table = '<br/><table>'
  for event in @calendar.events
     table += "<tr><td" 
     if event.type == "H" then table += ' class="Hospital" '
     elsif event.type == "I" then table += ' class="Illness" ' 
     elsif event.type == "M" then table += ' class="Medication" '
     end
     
     table += ">#{event.label}</td><td>#{event.date}</td><td>#{event.summary}</td></tr>"
  end 
  table += "</table></br>"
  
  chart = "<table width=#{width}><tr>"

  
  while i < @calendar.events.size
     
    currentDate = @calendar.events[i].date
    previousDate = currentDate if previousDate.nil?
    
    
    chart += "<td width= #{cell_width}>"
       
      while i < @calendar.events.size && @calendar.events[i].date == currentDate
        chart += '<table><tr><td'
        
        if @calendar.events[i].type == "H" then chart += ' class="Hospital" '
         elsif @calendar.events[i].type == "I" then chart += ' class="Illness" ' 
         elsif @calendar.events[i].type == "M" then chart += ' class="Medication" '
        end
     
        chart += ">" +@calendar.events[i].label + "</td></tr></table><br/>"
        i += 1
      end #@calendar... == currentDate

      
    chart += "</td>"
    column += 1
    if column >=  max_column 
      column = 0
      chart += "</tr><tr><td colspan = #{ max_column }><div align = left>#{[previousDate]}</div><div align = right>#{@calendar.events[i].date}</div></td></tr><tr>"
      previousDate = @calendar.events[i].date
    end
  end #while x< @cal...
  
#  while column < max_column 
#    chart += "<td width = #{cell_width}></td>"
#    column += 1
#  end 
  
  chart += "</tr><tr><td colspan = #{ max_column }><div align = left>#{previousDate}</div><div align = right>#{@calendar.events.last.date}</div></td></tr><tr>"
  chart += "</tr></table>"
  
  chart += "<br/><h3>Summary</h3>[H = Hospital Medical Event, I = Illness History]<br/>" + table 
  
end







#---------------------------------------------

class ADate

 # @date
 # @illnesses
 # @hospitals
 # @medications
 
  attr_accessor :date, :illnesses, :hospitals, :medications
  
  def initialize(d)
    @date = d.to_date
    @illnesses = []
    @hospitals = [] 
    @medications = []
  end
  
  def date=(d)
    @date = d.to_date
  end
  
  def illnesses=(ill)
    @illnesses.push(ill)
  end
  
  def hospitals=(hosp)
    @hospitals.push(hosp)
  end
  
  def medications=(med)
    @medications.push(med)
  end  

  
end #ADate


#------------------------------------------------

def make_table_styled
  i = 0
  column = 0
  width = 850
  max_column = 15
  cell_width = width / max_column
  
   min_date = nil
  max_date = nil

  
  @table_styled = {}
  counter = 0

  unless @medical_histories.nil?
    for med in @medical_histories
      counter += 1
      #raise med.approx_date.to_date.hash
      if @table_styled[med.approx_date.to_date.hash].nil? then    
        @table_styled[med.approx_date.to_date.hash] = ADate.new(med.approx_date)  
      end #null date
     
      #raise @table_styled.to_yaml
      # #{med.approx_date.to_date.strftime("%d %b '%y")}
      @table_styled[med.approx_date.to_date.hash].hospitals = Event.new(med.approx_date.to_date, "P#{counter}" , "<em>Procedure: </em>#{med.problem}, <em>InPatient: </em>#{if med.required_hospitalization then 'Yes' else 'No' end}, <em>Dr: </em>#{med.doctor}, <em>Facility: </em>#{med.hospital},","P")
    
    end
  end
  
   
  unless @illness.nil?
    counter = 0
    for ill in @illness
      counter += 1
      if @table_styled[ill.date.to_date.hash].nil? then
        @table_styled[ill.date.to_date.hash] = ADate.new(ill.date)
      end #null date
      
      #i need to add a date field for this.
      # <br/>#{ill.date.to_date.strftime("%d %b '%y")}
      @table_styled[ill.date.to_date.hash].illnesses = Event.new(
        ill.date.to_date, 
        "C#{counter}", 
        "Condition: #{ill.title}, Controlled: #{if ill.controlled then 'Yes' else 'No' end}, Family History: #{if ill.in_family_history then 'Yes' else 'No' end}", "C")
    end 
  end


  unless @medications.nil?
    counter = 0
    for med in @medications
      counter += 1
      if @table_styled[med.prescribed_start.to_date.hash].nil? then
        @table_styled[med.prescribed_start.to_date.hash] = ADate.new(med.prescribed_start)
      end #null date
      # <br/>#{med.prescribed_start.to_date.strftime("%d %b '%y")}
      @table_styled[med.prescribed_start.to_date.hash].medications = Event.new(
        med.prescribed_start.to_date, 
        "M#{counter}", 
        "Medication:#{med.name}, Dosage:#{med.strength} #{med.unit_type}, Objective:#{med.purpose}",  "M")
        
    end
  end


  
  #raise @table_styled.inspect
 
  @table_styled = @table_styled.sort
  
  table = '<br/><h3>Timeline</h3><table>'
  
  table += '<tr><td class="Illness">Condition</td>'
  @table_styled.each {|day, day_value| 
    table += "<td>"
    day_value.illnesses.each {| ill | 
     table += "#{ill.label}<br/>"
    }  
    table += "</td>"
  }
  
   
  table += '<tr><td class="Hospital">Procedure</td>'
  
  @table_styled.each {|day, day_value| 
    table += "<td>"
    day_value.hospitals.each {| hosp | 
     table += "#{hosp.label}<br/>"
    }  
    table += "</td>"
  }
  
  table += "</tr>" 
  
  

  
  table += '<tr><td class="Medication">Prescription</td>'
  @table_styled.each {|day, day_value| 
  
    if (min_date == nil) then 
      min_date = day_value.date
      max_date = min_date
    else
      if day_value.date > max_date then max_date = day_value.date end
      if day_value.date < min_date then min_date = day_value.date end #probably not needed.
    end
  
    table += "<td>"
    day_value.medications.each {| med | 
     table += "#{med.label}<br/>"
    }  
    table += "</td>"
  }  
  
  cells = @table_styled.size + 1
  l_cells = cells / 2
  r_cells = cells - l_cells
  
  table += "</tr><tr><td colspan=#{l_cells}>#{min_date.to_s(:long)}</td><td colspan=#{r_cells } align=right>#{max_date.to_s(:long)}</td></tr></table></br>"
 
  summary = "<br/><table><tr><th></th><th>Date</th><th>Summary</th></tr>"

 
  @table_styled.each {|day, day_value| 
    

    day_value.illnesses.each {| value |
     cls = '"Illness"'
     summary += "<tr><td class=#{cls}>#{value.label}</td><td>#{value.date.to_s(:long)}</td><td>#{value.summary}</td></tr>"
    }   
  
    day_value.hospitals.each {| value |
      cls='"Hospital"'
      summary += "<tr><td class=#{cls}>#{value.label}</td><td>#{value.date.to_s(:long)}</td><td>#{value.summary}</td></tr>"
    }  
  

    
    day_value.medications.each {| value |
      cls='"Medication"'
      summary += "<tr><td class=#{cls}>#{value.label}</td><td>#{value.date.to_s(:long)}</td><td>#{value.summary}</td></tr>"
    }  
  }  
  summary += "</table>"
  
  
 
         #if @calendar.events[i].type == "H" then chart += ' class="Hospital" '
         #elsif @calendar.events[i].type == "I" then chart += ' class="Illness" ' 
         #elsif @calendar.events[i].type == "M" then chart += ' class="Medication" '
        #end
     
        #chart += ">" +@calendar.events[i].label + "</td></tr></table><br/>"
        #i += 1
 
 
  table + summary
  
end



 
end # ends helper

