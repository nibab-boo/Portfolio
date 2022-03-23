Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "/myJourney", to: "pages#journey", as: :journey
  resources :projects, only: [:index, :show, :edit, :create, :new, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
