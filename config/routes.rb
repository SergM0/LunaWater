Rails.application.routes.draw do
  get 'login', to: 'sesiones#new'
  post 'login', to: 'sesiones#create'
  delete 'logout', to: 'sesiones#destroy'

  get 'mediciones', to: 'mediciones#index'
  root to: 'sesiones#new'
end
