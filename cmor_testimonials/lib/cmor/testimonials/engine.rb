module Cmor
  module Testimonials
    class Engine < ::Rails::Engine
      isolate_namespace Cmor::Testimonials

      config.generators do |g|
        g.test_framework :rspec, fixture: false
        g.fixture_replacement :factory_bot
        g.factory_bot dir: 'spec/factories'
      end

    end
  end  
end
