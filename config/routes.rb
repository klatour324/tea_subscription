Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :customers, only: [:create] do
        resources :subscriptions, only: [:create, :update]
      end
      resources :teas, only: [:create]
    end
  end
end
