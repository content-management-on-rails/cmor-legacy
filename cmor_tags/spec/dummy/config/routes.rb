Rails.application.routes.draw do
  resources :posts

  mount Cmor::Tags::Engine, at: '/tags'
end
