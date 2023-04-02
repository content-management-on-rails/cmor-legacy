module Cmor
  module Faq
    module Api
      class Engine < ::Rails::Engine
        isolate_namespace Cmor::Faq::Api
        config.generators.api_only = true

        config.generators do |g|
          g.test_framework :rspec
        end
      end
    end
  end
end
