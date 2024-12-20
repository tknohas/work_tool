Rails.application.routes.draw do
  namespace :tasks do
    get "completed/new"
  end
  root 'tasks#index'

  resource :session
  resources :passwords, param: :token
  resources :tasks, only: %i[index show new create edit update destroy] do
    resource :completed, only: %i[create destroy], module: :tasks
    resource :start, only: %i[create destroy], module: :tasks
    resource :stopped, only: %i[create destroy], module: :tasks
  end
  resources :daily_reports, only: %i[index show new create edit update]
  resources :kpt_items, only: %i[index new create show edit update] do
    member do
      get 'suggest_try'
      get 'dig_into_problem'
    end
  end

  post 'kpt_items/suggest_try', to: 'kpt_items#suggest_try'
end
