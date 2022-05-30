module Cmor::Core::Api
  class Engine < ::Rails::Engine
    isolate_namespace Cmor::Core::Api
    config.generators.api_only = true
  end
end
