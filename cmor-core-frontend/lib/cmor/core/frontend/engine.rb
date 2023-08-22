module Cmor
  module Core
    module Frontend
      class Engine < ::Rails::Engine
        isolate_namespace Cmor::Core::Frontend
      end
    end
  end
end
