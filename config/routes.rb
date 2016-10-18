Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :events do
  	resources :attendees, :controller => "event_attendees"
    
    collection do
      post :bulk_update
      get :latest
    end

    member do
      get :dashboard
    end
  end
  
  namespace :admin do
    resources :events
  end

  namespace :api do
    constraints(subdomain: 'api') do
      resources :users, only: [:show]
      get '*unmatched_route', to: 'base#page_404'
    end
  end
  # namespace :api do
  #   resources :users, only: [:show]
  #   get '*unmatched_route', to: 'base#page_404'
  # end
  resources :people
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/welcome/say_hello" => "welcome#say"
  get "welcome" => "welcome#index"

  get "/ajax" => "welcome#ajax"
  get "/ajaxtest" => "welcome#ajaxtest"
  root :to =>"events#index"

  #外卡路由
  #match ':controller(/:action(/:id(.:format)))', :via => :all
end
