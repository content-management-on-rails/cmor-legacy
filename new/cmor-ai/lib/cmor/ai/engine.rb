module Cmor
  module Ai
    class Engine < ::Rails::Engine
      isolate_namespace Cmor::Ai

      config.generators do |g|
        g.test_framework :rspec
        g.fixture_replacement :factory_bot, dir: "spec/factories"
      end
    end
  end
end
