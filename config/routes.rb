Rails.application.routes.draw do

  root "welcome#index"
  resources :users
  get '/signin' => "users#signin"

  resources :rides

  resources :attractions

end
