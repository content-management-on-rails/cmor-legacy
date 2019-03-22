Cmor::Tags::Engine.routes.draw do
  localized do
    scope :cmor_tags_engine do
      resources :searchs, only: [:new, :create]
      # resources :tag_searchs, only: [:new, :create] do
      #   get '/', on: :collection, to: "tag_searchs#create"
      # end

      get '/:tag_list', to: "searchs#create" # , as: 'tag'

      root to: 'searchs#new'
    end
  end
end
