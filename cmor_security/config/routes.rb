Cmor::Security::Engine.routes.draw do
  resources :antivirus_configurations, only: [:index]
  root to: 'home#index'
end
