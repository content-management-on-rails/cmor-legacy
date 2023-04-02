module Cmor
  module TimeTracking
    module Api
      class Engine < ::Rails::Engine
        isolate_namespace Cmor::TimeTracking::Api
        config.generators.api_only = true

        config.generators do |g|
          g.test_framework :rspec
        end
      end
    end
  end
end
