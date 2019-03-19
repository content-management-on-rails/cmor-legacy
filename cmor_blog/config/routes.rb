Cmor::Blog::Engine.routes.draw do
  localized do
    scope :cmor_blog_engine do
      resources :posts, only: [:index, :show] do
        get 'page/:page', action: :index, on: :collection
        get ':year/:month/:day', action: :index, on: :collection, constraints: { year: /\d+/, month: /\d+/, day: /\d+/ }, as: :day
        get ':year/:month', action: :index, on: :collection, constraints: { year: /\d+/, month: /\d+/ }, as: :month
        get ':year', action: :index, on: :collection, constraints: { year: /\d+/ }, as: :year
      end

      root to: 'posts#index'
    end
  end
end
