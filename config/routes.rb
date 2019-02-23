Rails.application.routes.default_url_options[:host] = ENV["HOST"]

Rails.application.routes.draw do
  resources :ballots, only: [:show] do
    get "national", on: :collection
    get "local", on: :collection
    post "vote", on: :member
  end

  resources :polls, only: [:index, :show] do
    post "vote", on: :member
  end

  post "authentication/authenticate"
  get "authentication/fetch"

  resources :users, only: [:update] do
    get "demographics", on: :collection
    get "locations", on: :collection
  end

  resources :provinces, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
