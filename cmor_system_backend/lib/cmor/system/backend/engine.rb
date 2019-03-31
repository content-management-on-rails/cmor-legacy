module Cmor
  module System
    module Backend
      class Engine < ::Rails::Engine
        isolate_namespace Cmor::System::Backend
      end
    end
  end
end