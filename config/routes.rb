Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "/myJourney", to: "blogs#journey", as: :journey
  resources :blogs, except: [:index, :show, :delete]
  resources :projects, only: [:index, :show, :edit, :create, :new, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
