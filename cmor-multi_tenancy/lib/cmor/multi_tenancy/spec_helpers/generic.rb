module Cmor
  module MultiTenancy
    module SpecHelpers
      # Usage:
      #
      #     # spec/support/cmor-multi_tenancy.rb
      #     require 'cmor/multi_tenancy/spec_helpers/generic'
      #
      #     RSpec.configure do |config|
      #       config.include Cmor::MultiTenancy::SpecHelpers::Generic, type: :feature
      #       config.include Cmor::MultiTenancy::SpecHelpers::Generic, type: :system
      #     end
      #
      module Generic
        def with_client(client)
          Cmor::MultiTenancy.with_client(client) { yield }
        end
      end
    end
  end
end
