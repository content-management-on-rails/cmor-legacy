Cmor::Legal::Engine.routes.draw do
  if Cmor::Legal::Configuration.integrate_with_cmor_cms?
    resources :privacy_policies do
      post :toggle_published, on: :member
    end
  end

  resources :personal_data, only: [:index, :show]
  root to: "home#index"
end
