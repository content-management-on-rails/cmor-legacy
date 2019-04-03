Cmor::Testimonials::Backend::Engine.routes.draw do
  resources :categories
  resources :testimonials
  
  root to: 'home#index'
end
