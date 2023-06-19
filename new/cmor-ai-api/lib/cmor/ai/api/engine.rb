module Cmor
  module Ai
    module Api
      class Engine < ::Rails::Engine
        isolate_namespace Cmor::Ai::Api
        config.generators.api_only = true

        config.generators do |g|
          g.test_framework :rspec
        end
      end
    end
  end
end
