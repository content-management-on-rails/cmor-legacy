module Cmor::Showcase
  class Engine < ::Rails::Engine
    isolate_namespace Cmor::Showcase

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end
  end
end
