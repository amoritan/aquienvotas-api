Rails.application.routes.draw do
  resources :ballots, only: [:index, :show] do
    post 'vote', on: :member
  end

  post 'authentication/authenticate'
  get 'authentication/fetch'

  resources :users, only: [:update]

  resources :provinces, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
