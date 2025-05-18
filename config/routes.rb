Rails.application.routes.draw do
  # Rutas para sesiones
  get    'login',  to: 'sesiones#new'
  post   'login',  to: 'sesiones#create'
  delete 'logout', to: 'sesiones#destroy'

  # Rutas para dashboard
  controller :dashboard do
    get 'dashboard/index'
    get 'dashboard/flujo',        as: :dashboard_flujo
    get 'dashboard/volumen',      as: :dashboard_volumen
    get 'dashboard/distribucion', as: :dashboard_distribucion
    get 'dashboard/datos',        as: :dashboard_datos
    get 'dashboard/flujo', to: 'dashboard#flujo'

  end

  get 'dashboard/exportar', to: 'dashboard#exportar', as: :exportar_dashboard



  # Rutas para mediciones
  get 'mediciones', to: 'mediciones#index'

  # Ruta raíz
  root to: 'dashboard#index'
end
