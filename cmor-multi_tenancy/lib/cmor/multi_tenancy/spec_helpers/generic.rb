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
      module Generic
        def with_client(client)
          Cmor::MultiTenancy.with_client(client) { yield }
        end
      end
    end
  end
end
