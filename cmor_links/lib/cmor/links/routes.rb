module Cmor
  module Links
    module Routes
      def self.routes(r)
        r.resources :categories, only: [:index, :show]
      end
    end
  end
end
