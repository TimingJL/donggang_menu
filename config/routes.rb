Rails.application.routes.draw do
  devise_for :users
  resources :restaurants do
    member do
        get "like", to: "restaurants#upvote"
        get "dislike", to: "restaurants#downvote"
    end 	
  	resources :items
  	resources :comments
  end
  resources :categories 

  root 'restaurants#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
