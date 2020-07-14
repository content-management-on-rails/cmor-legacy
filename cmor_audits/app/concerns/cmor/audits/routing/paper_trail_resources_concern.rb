module Cmor
  module Audits
    module Routing
      module PaperTrailResourcesConcern
        extend ActiveSupport::Concern

        # Example:
        #
        #     # config/routes.rb
        #     Rails.application.routes.draw do
        #       resources :pages do
        #         paper_trail_resources
        #       end
        #     end
        #
        # This will give you:
        #
        #     $> rails routes
        #                             GET    /pages/:id/versions/:version_id(.:format)        cmor/cms/backend/pages#version
        #                             GET    /pages/:id/version_at(/:version_at)(.:format)    cmor/cms/backend/pages#version_at
        #               versions_page GET    /pages/:id/versions(.:format)                    cmor/cms/backend/pages#versions
        #                       pages GET    /pages(.:format)                                 cmor/cms/backend/pages#index
        #                             POST   /pages(.:format)                                 cmor/cms/backend/pages#create
        #                    new_page GET    /pages/new(.:format)                             cmor/cms/backend/pages#new
        #                   edit_page GET    /pages/:id/edit(.:format)                        cmor/cms/backend/pages#edit
        #                        page GET    /pages/:id(.:format)                             cmor/cms/backend/pages#show
        #                             PATCH  /pages/:id(.:format)                             cmor/cms/backend/pages#update
        #                             PUT    /pages/:id(.:format)                             cmor/cms/backend/pages#update
        #
        def paper_trail_resources
          get "versions/:version_id", on: :member, action: :version
          get "version_at(/:version_at)", on: :member, action: :version_at
          get "versions", on: :member, action: :versions
        end
      end
    end
  end
end
