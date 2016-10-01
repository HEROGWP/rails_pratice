Rails.application.routes.draw do
  resources :events do
  	resources :attendees, :controller => "event_attendees"
    
    collection do
      post :bulk_update
      get :latest
    end
  end
  


  resources :people
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/welcome/say_hello" => "welcome#say"
  get "welcome" => "welcome#index"
  root :to =>"welcome#index"

  #外卡路由
  #match ':controller(/:action(/:id(.:format)))', :via => :all
end
