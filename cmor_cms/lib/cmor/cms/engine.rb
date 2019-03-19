module Cmor
  module Cms
    class Engine < ::Rails::Engine
      isolate_namespace Cmor::Cms
      
      config.app_generators do |c|
        c.test_framework :rspec, fixture: true,
                                 fixture_replacement: nil

        c.integration_tool :rspec
        c.performance_tool :rspec

      end
    end
  end
end
