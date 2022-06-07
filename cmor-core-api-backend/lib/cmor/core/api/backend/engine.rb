module Cmor
  module Core
    module Api
      module Backend
        class Engine < ::Rails::Engine
          isolate_namespace Cmor::Core::Api::Backend
        end
      end
    end
  end
end
