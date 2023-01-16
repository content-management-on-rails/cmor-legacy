Cmor::Partners::Engine.routes.draw do
  resources :partners do
    acts_as_published
    acts_as_list
  end

  resources :categories do
    acts_as_published
    acts_as_list
  end

  root to: "home#index"
end
