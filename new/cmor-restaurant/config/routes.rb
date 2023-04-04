Cmor::Restaurant::Engine.routes.draw do
  resources :categories do
    acts_as_published
    acts_as_list
  end

  root to: "home#index"
end
