Rails.application.routes.draw do

	resources :events
  post '/events/:id/comments' =>'events#com_create', as: "new_com"
	patch '/events/:id/join' =>'events#add_member'
  get '/' =>'users#index'
  post '/users' =>'users#create'
  post '/' =>'users#login'
  get 'users/:id' =>'users#edit'
  patch 'users/:id' => 'users#update'
  delete 'userss/:id' =>'users#sdestroy'
  get 'error' =>'users#error'
  match '*path' => redirect('/error'), via: :get   

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
