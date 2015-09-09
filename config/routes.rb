Rails.application.routes.draw do

  devise_for :teams

  resources :teams, path: "/", only: [] do
    resources :pairs, only: [:index] do
      collection do
        get :match_pairs
      end
    end
    resources :groups, only: [:index, :create, :edit, :destroy] do
      resources :members, only: [:index, :create, :destroy]
    end
  end

  root 'welcome#index'

end
