Cmor::Tags::Api::Engine.routes.draw do
  resources :tags
  resources :searchs, only: [:create], controller: 'search_services'
  resources :tag_clouds, only: [:create], controller: 'tag_cloud_services'
end
