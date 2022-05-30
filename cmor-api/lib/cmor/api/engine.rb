module Cmor::Api
  class Engine < ::Rails::Engine
    isolate_namespace Cmor::Api
    config.generators.api_only = true
  end
end
