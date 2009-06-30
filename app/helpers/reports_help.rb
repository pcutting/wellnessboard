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


