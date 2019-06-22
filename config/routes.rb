Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'dashboards#index'
  resources :projects do
  	resources :tasks
  end
  post 'status_update' => 'tasks#status_update'
  get 'projects/:id/chart' => 'projects#chart', as: :project_chart
end
