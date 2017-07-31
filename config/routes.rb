Rails.application.routes.draw do

  resources :articles do
    resources :sections
  end

  devise_for :users, path: 'auth', controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
