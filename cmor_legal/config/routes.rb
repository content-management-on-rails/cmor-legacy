Cmor::Legal::Engine.routes.draw do
  resources :privacy_policies do
    post :toggle_published, on: :member
  end if Cmor::Legal::Configuration.integrate_with_cmor_cms?

  resources :personal_data, :only => [:index, :show]
  root to: 'home#index'
end
