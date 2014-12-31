Rails.application.routes.draw do

  devise_for :users

  resources :users, path: "/", only: [] do
    get 'settings', on: :member
    resources :groups, only: [:create, :edit, :destroy]
  end

  root 'welcome#index'

end
