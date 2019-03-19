module Cmor
  module Core
    module Backend
      class Engine < ::Rails::Engine
        isolate_namespace Cmor::Core::Backend
      end
    end
  end
end