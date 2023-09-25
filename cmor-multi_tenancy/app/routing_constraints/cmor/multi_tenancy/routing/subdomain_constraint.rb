module Cmor
  module MultiTenancy
    module Routing
      # Example:
      #
      #     config/routes.rb:
      #     Rails.application.routes.draw do
      #       constraints Cmor::MultiTenancy::Routing::SubdomainConstraint do
      #         root to: 'home#index'
      #       end
      #     end
      class SubdomainConstraint
        def self.matches?(request)
          if request.subdomain.present?
            ENV['client_identifier'] = request.subdomain
            true
          end
        end
      end
    end
  end
end
