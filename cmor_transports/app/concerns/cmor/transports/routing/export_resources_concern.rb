# frozen_string_literal: true

module Cmor
  module Transports
    module Routing
      # Example:
      #
      #     Rails.application.routes.draw do
      #       resources :posts do
      #         export_resources
      #       end
      #     end
      #
      # This will give you:
      #
      #                    Prefix Verb URI Pattern
      #             export_posts GET    /posts/export(.:format)                          posts#export
      #               dump_posts POST   /posts/dump(.:format)                            posts#dump
      #
      module ExportResourcesConcern
        extend ActiveSupport::Concern

        def export_resources
          get :export, on: :collection
          post :dump, on: :collection
        end
      end
    end
  end
end
