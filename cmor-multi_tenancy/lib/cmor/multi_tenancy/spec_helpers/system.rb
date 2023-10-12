module Cmor
  module MultiTenancy
    module SpecHelpers
      # Usage:
      #
      #     # spec/support/cmor_multi_tenancy.rb
      #     require 'cmor/multi_tenancy/spec_helpers/system'
      #
      #     RSpec.configure do |config|
      #       config.include Cmor::MultiTenancy::SpecHelpers::System, type: :feature
      #       config.include Cmor::MultiTenancy::SpecHelpers::System, type: :system
      #     end
      #
      module System
        def with_subdomain(identfier)
          @_original_host = Capybara.default_host
          Capybara.default_host = @_original_host.gsub(/(:\/\/[a-z0-9-]{1,})\./, "://#{identfier}.")
          yield
          Capybara.default_host = @_original_host
        end
      end
    end
  end
end
