Cmor::Restaurant::Engine.routes.draw do
  resources :additives do
    acts_as_published
    acts_as_list
  end

  resources :allergens do
    acts_as_published
    acts_as_list
  end

  resources :categories do
    acts_as_published
    acts_as_list
  end

  resources :foods do
    acts_as_published
    acts_as_list
  end

  root to: "home#index"
end
