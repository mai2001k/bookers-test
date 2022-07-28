Rails.application.routes.draw do
  get 'users/show'
  devise_for :users, controllers:{
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  resources :books
  resources :users
  get 'home/about' => 'homes#about'
end
