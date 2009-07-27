class Profile < ActiveRecord::Base
  belongs_to :user
  
  
  def bmi 

   
    
    unless  self.user.weights.last.nil?
      ret = (( self.user.weights.last.weight / (hight_in_inches * hight_in_inches.to_f)) * 703 ).to_i 
    else 
     ret =  "Please enter your weight."
    end
    
    ret
  end
  
  
  
  def hight_in_inches
       hight_feet * 12 + hight_inches
  end
  
  def age  
(( Time.now - dob.to_time ) / 1.years).to_i
end
  
end
