module Cmor
  module UserArea
    module Frontend
      class Engine < ::Rails::Engine
        isolate_namespace Cmor::UserArea::Frontend

        config.generators do |g|
          g.test_framework :rspec
          g.factory_bot dir: "spec/factories"
        end
      end
    end
  end
end
