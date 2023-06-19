module Cmor
  module Invoicing
    module Api
      class Engine < ::Rails::Engine
        isolate_namespace Cmor::Invoicing::Api
        config.generators.api_only = true

        config.generators do |g|
          g.test_framework :rspec
        end
      end
    end
  end
end
