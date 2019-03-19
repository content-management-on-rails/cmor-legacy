Cmor::Tags::Backend::Engine.routes.draw do
  resources :tags
  resources :taggings do
    post 'create_by_gid_and_tag', on: :collection
    post 'set_by_gid_and_tag',    on: :collection
  end

  root to: 'home#index'
end
