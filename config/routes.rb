Rails.application.routes.draw do
  root 'tasks#index'

  resource :session
  resources :passwords, param: :token
  resources :tasks, only: %i[index show new create edit update destroy]
  resources :daily_reports, only: %i[index show new create edit update] do
    resource :kpt_item, only: %i[new create], module: :daily_reports
  end
end
