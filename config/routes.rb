Rails.application.routes.draw do
  # resources :ballots, only: [:index]
  get 'ballots/national'

  post 'authentication/authenticate'
  get 'authentication/fetch'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
