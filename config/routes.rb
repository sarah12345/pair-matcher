Rails.application.routes.draw do

  devise_for :users

  resources :users, path: "/", only: [] do
    get 'configure', on: :member
  end

  root 'welcome#index'

end
