Cmor::Audits::Engine.routes.draw do
  root to: 'home#index'

  namespace :paper_trail do
    resources :versions do
      post :destroy_many, on: :collection
    end
  end
end
