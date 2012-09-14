Hhreboot2::Application.routes.draw do
  mount Forem::Engine, :at => "/forums"
  devise_for :users

  resources :users


  root :to => 'users#index'

 
end
