Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get "/result", to: "spots#result"

  resources :spots, only: :index do
    collection do
      get :share
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
