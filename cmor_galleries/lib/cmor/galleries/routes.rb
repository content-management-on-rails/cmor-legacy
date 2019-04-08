module Cmor
  module Galleries
    module Routes
      def self.routes(r)
        r.resources :picture_galleries do
          r.post :toggle_published, on: :member
        end
      end
    end
  end
end
