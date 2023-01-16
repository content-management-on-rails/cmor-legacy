module Cmor::Testimonials
  class Engine < ::Rails::Engine
    isolate_namespace Cmor::Testimonials

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end
  end
end
