########################################################################################
########################################################################################
####                                                                                ####
####  This file is part of AQuienVotas.                                             ####
####                                                                                ####
####  AQuienVotas is free software: you can redistribute it and/or modify           ####
####  it under the terms of the GNU Affero General Public License as published by   ####
####  the Free Software Foundation, either version 3 of the License, or             ####
####  (at your option) any later version.                                           ####
####                                                                                ####
####  AQuienVotas is distributed in the hope that it will be useful,                ####
####  but WITHOUT ANY WARRANTY; without even the implied warranty of                ####
####  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                 ####
####  GNU Affero General Public License for more details.                           ####
####                                                                                ####
####  You should have received a copy of the GNU Affero General Public License      ####
####  along with AQuienVotas.  If not, see <https://www.gnu.org/licenses/>.         ####
####                                                                                ####
########################################################################################
########################################################################################



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
    get "amount", on: :collection
  end

  resources :provinces, only: [:index]

  root "status#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
