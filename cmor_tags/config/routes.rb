Cmor::Tags::Engine.routes.draw do
  localized do
    scope :cmor_tags_engine do
      resources :tag_searchs, only: [:new, :create] do
        get '/', on: :collection, to: "tag_searchs#create"
      end

      get '/:tag', to: "tag_searchs#create", as: 'tag'

      root to: 'tag_searchs#new'
    end
  end
end
