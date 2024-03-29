Rails.application.routes.draw do
  devise_for :users
  root to: "movies#index"
  resources :movies do
    resources :ratings, only: [:create]
    resources :reviews
  end
end
