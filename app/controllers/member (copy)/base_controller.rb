class BaseController < ApplicationController
  
  before_filter :current_user
  #before_filter :must_be_member
  layout "/member/layouts/member"
  helper :all
  #before_filter :load_member_conditions

  
  def load_member_conditions
    @roles = current_user.roles.find(:all, :conditions => ["has_role = ? OR has_role = ?", "MEMBER","SUPER MEMBER" ])
    @member_conditions = Array.new
    @member_roles = Array.new
    
    #consider getting rid of this and just doing @roles.each {|role| role.conditions ... }
    @roles.each do |role|
      @member_conditions << role.conditions
      @member_roles << role.has_role
    end
    
    @member_roles.uniq!
  end
  
  
protected #-----------------------------

  def must_be_member
    raise NoPermission if  @current_user.roles.find(:all, :conditions => ["has_role = ? OR has_role = ?", "MEMBER","SUPER MEMBER" ]) == [] 
  end
  

end
