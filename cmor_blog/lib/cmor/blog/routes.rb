module Cmor
  module Blog
    module Routes
      def self.routes(r)
        r.resources :posts, only: [:index, :show] do
          r.get 'page/:page', action: :index, on: :collection
          r.get ':year/:month/:day', action: :index, on: :collection, constraints: { year: /\d+/, month: /\d+/, day: /\d+/ }, as: :day
          r.get ':year/:month', action: :index, on: :collection, constraints: { year: /\d+/, month: /\d+/ }, as: :month
          r.get ':year', action: :index, on: :collection, constraints: { year: /\d+/ }, as: :year
        end

        r.root to: 'posts#index'
      end
    end
  end
end
