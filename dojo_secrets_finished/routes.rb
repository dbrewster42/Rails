Rails.application.routes.draw do
  resources :secrets 
  post 'likes/:secret_id' => 'secrets#lcreate'
  delete 'likes/:secret_id' => 'secrets#ldestroy'

  get 'users/new' => 'users#new'
  post 'users' => 'users#create'
  get 'users/:id' => 'users#show', as: "show_user"

  get 'users/:id/edit' =>'users#edit'
  patch 'users/:id' => 'users#update'
  delete 'users/:id'=> 'users#destroy'

  get 'sessions/new' => 'sessions#new'
  post 'sessions' => 'sessions#create'
  delete 'sessions/:id' => 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
