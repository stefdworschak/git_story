Rails.application.routes.draw do
  resources :comments
  resources :profiles
  devise_for :users
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'home#index'
  get '/signedinuserprofile' => 'profiles#signedinuserprofile'
  get '/codeview' => 'codeview#index'
  get '/playground' => 'playground#index'
end
