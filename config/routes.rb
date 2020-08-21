Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :time_report, only: [:create]
  get '/payroll_report', to: 'payroll_report#index'
end
