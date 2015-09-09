Rails.application.routes.draw do

  devise_for :teams

  resources :teams, path: "/", only: [:show] do
    resources :groups, only: [:index, :create, :edit, :destroy] do
      resources :members, only: [:index, :create, :destroy]
    end
  end

  root 'welcome#index'

end
