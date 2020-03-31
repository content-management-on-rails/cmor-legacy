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
      end
    end
  end
end
