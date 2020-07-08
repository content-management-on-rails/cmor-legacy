module Cmor
  module Audits
    module Routing
      module PaperTrailResourcesConcern
        extend ActiveSupport::Concern

        def paper_trail_resources
          # get "paper_trails/:version_id", on: :member, action: :paper_trails_version, constraints: { version_id: /\d+/ }
          # get "paper_trails/:timestamp", on: :member, action: :paper_trails_version_at, constraints: lambda { |params, request|
          #   begin
          #     DateTime.parse(params[:timestamp])
          #   rescue ArgumentError
          #     false
          #   else
          #     true
          #   end
          # }
          # get "paper_trails", on: :member, action: :paper_trails

          get "versions/:version_id", on: :member, action: :version
          get "versions_at(/:version_at)", on: :member, action: :version_at
          get "versions", on: :member, action: :versions

          # namespace :paper_trail do
          #   resources :versions, only: [:index, :show], :controller: 'cmor/audits/paper_trail/resources/versions_controller'
          # end
        end
      end
    end
  end
end
