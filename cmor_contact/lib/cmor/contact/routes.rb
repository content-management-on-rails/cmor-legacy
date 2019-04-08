module Cmor
  module Contact
    module Routes
      def self.routes(r)
        r.resources :contact_requests, only: [:create, :index]

        r.root to: 'contact_requests#index'
      end
    end
  end
end
