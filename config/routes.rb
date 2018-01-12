require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :bookings, only: [:index, :update] do
        collection { get 'search' }
      end
    end
  end

  mount Sidekiq::Web => '/sidekiq'
  mount_ember_app :frontend, to: '/'
end
