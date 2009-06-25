ActionController::Routing::Routes.draw do |map|


  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"  
  
  map.root :controller => "users"
  map.resources :users
  map.resources :user_sessions


map.namespace :member do |member|
    #admin.root :controller => "home", :action => 'show'
    #admin.resource :home, :controller => "home"
  member.root :controller => "homes" , :action => "index"
  member.resources :homes
  member.resources :offer_restrictions
  member.resources :offer_accesses
  member.resources :offer_skus
  member.resources :coupons
  member.resources :items
  member.resources :orders
  member.resources :comments
  member.resources :blogs
  member.resources :catalogs
  member.resources :promotions
  member.resources :quick_facts
  member.resources :my_foods
  member.resources :foods
  member.resources :my_exercises
  member.resources :exercises
  member.resources :body_scans
  member.resources :measurements
  member.resources :goals
  member.resources :shake_recipes
  member.resources :quick_supports
  member.resources :waters
  member.resources :weights
  member.resources :sponsors
  member.resources :profiles
  
end

  # The priority is based upon order of creation: first created -> highest priority.
  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action
  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)
  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products
  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }
  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end
  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end
  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"
  # See how all your routes lay out with "rake routes"
  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
