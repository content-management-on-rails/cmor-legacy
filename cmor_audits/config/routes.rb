Cmor::Audits::Engine.routes.draw do
  root to: 'home#index'

  namespace :paper_trail do
    resources :versions
  end
end
