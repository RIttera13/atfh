Rails.application.routes.draw do
  resources :jobs do
    post 'accept_job'
    post 'backup_job'
  end

  resources :dashboards
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :user
  resources :users, only: [:new, :create, :show, :index, :edit, :update, :profile, :destroy, :metrics]

  resources :organizations, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
    member do
       put :re_activate
    end
  end

  resources :sports, only: [:new, :create, :show, :index, :edit, :update, :destroy]

  resources :locations, only: [:new, :create, :show, :index, :edit, :update, :destroy]

  get 'profile' => 'users#profile'
  get 'metrics' => 'users#metrics'

  authenticated :user do
    root to: "dashboards#index", as: :authenticated_root
  end
  unauthenticated do
    root to: "dashboards#index", as: :unauthenticated_root
  end

  root 'dashboards#index'
end
