DGD::Application.routes.draw do
  

  namespace :admin do
    
    resources :group, :only => [:index] do
      collection do
        post 'update'
      end
    end
    
    resources :user, :only => [:index] do
      collection do
        post 'update'
      end
    end
    
    resources :description, :only => [:index] do
      collection do
        post 'update'
      end
    end
    
    resources :category, :only => [:index] do
      collection do
        post 'update'
        get 'primary_categories'
      end
    end
    
  end
  
  resources :group, :only => [:index, :show, :edit, :update]  do
    collection do
      get 'leaderboard'
      get 'recently_updated'
      get 'least_updated'
    end
    resources :description, :except => [:edit] do
      post 'flag' => 'description#flag'
    end
  end
  
  get 'flag' => 'flag#index'

  match "/auth/:provider/callback" => "sessions#create"  
  match "/signout" => "sessions#destroy", :as => :signout  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'splash#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
