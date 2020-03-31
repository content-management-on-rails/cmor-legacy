module Cmor
  module MultiTenancy
    module Routing
      class SubdomainConstraint
        def self.matches?(request)
          if request.subdomain.present?
            request.params[:client_identifier] = request.subdomain
            true
          end
        end
      end
    end
  end
end
