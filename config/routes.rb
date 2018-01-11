Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :bookings, only: [:index] do
        collection { get 'search' }
      end
    end
  end

  mount_ember_app :frontend, to: '/'
end
