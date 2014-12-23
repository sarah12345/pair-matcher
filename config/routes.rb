Rails.application.routes.draw do

  devise_for :users

  resources :users, path: "/", only: [] do
    resources :groups, only: [:index]
  end

  root 'welcome#index'

end
