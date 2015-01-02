Rails.application.routes.draw do

  devise_for :teams

  resources :teams, path: "/", only: [] do
    get 'settings', on: :member
    resources :groups, only: [:create, :edit, :destroy]
  end

  root 'welcome#index'

end
