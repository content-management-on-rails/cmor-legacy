module Cmor
  module Cms
   module Routes
      def self.routes(r)
        r.get '/*page', to: 'page#respond', as: :page
        r.get '/',      to: 'page#respond', page: 'home'
      end
    end
  end
end
