class BaseController < ApplicationController
  
  before_filter :current_user
 
  layout "/layouts/member"
  helper :all
  
 

end
