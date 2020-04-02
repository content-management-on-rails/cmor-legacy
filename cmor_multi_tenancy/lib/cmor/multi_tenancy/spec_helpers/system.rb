module Cmor
  module MultiTenancy
    module SpecHelpers
      module System
        def with_subdomain(identfier)
          @_original_host = Capybara.default_host
          Capybara.default_host = @_original_host.gsub(/(\:\/\/[a-z0-9-]{1,})\./, "://#{identfier}.")
          yield
          Capybara.default_host = @_original_host
        end

        def with_client(client)
          Cmor::MultiTenancy.with_client(client) { yield }
        end
      end
    end
  end
end
