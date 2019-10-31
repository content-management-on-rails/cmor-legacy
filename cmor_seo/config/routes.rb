Cmor::Seo::Engine.routes.draw do
  resources :items do
    acts_as_published
  end

  root to: 'home#index'
end
