module Cmor
  module Tags
    module Routes
      def self.routes(r)
        r.resources :searchs, only: [:new, :create]

        r.get '/:tag_list', to: "searchs#create"

        r.root to: 'searchs#new'
      end
    end
  end
end
