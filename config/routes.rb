Rails.application.routes.draw do
  resources :jobs do
    post 'accept_job'
  end

  resources :dashboards
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :user

  authenticated :user do
    root to: "dashboards#index", as: :authenticated_root
  end
  unauthenticated do
    root to: "dashboards#index", as: :unauthenticated_root
  end

  root 'dashboards#index'
end
