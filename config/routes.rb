# Routes for Dartmouth Group Directory
# See how all your routes lay out with "rake routes"

DGD::Application.routes.draw do
  root :to => 'splash#index'

  namespace :admin do

    resources :group, :only => [:index] do
      collection do
        post 'update'
        get 'foo'
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

    resources :flag, :only => [:index] do
      collection do
        post 'update'
      end
    end

    resources :group_exec, :only => [:index]

  end

  resources :group, :only => [:index, :show, :edit, :update]  do
    collection do
      get 'leaderboard'
      get 'recently_updated'
      get 'least_updated'
    end

    resources :flag, :only => [:index]
    resources :description, :only => [:new, :create, :index] do
      post 'flag' => 'description#flag'
      resources :flag, :only => [:index]
      collection do
        put 'checklist'
      end
    end

    resources :user, :only => [] do
      member do
        post 'petition'
      end
    end

  end

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  match "/open-sesame" => "sessions#open_sesame"

  # Misc
  match "/about" => "static_pages#about", :as => :about

end
