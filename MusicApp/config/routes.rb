Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :bands
  resources :albums,
    only: [:create, :new, :show, :update, :edit, :destroy]
  resources :tracks,
    only: [:create, :new, :show, :update, :edit, :destroy]
  resources :users, only: [:create, :new, :show]
  resource :session, only: [:create, :new, :destroy]

end
