module Cmor
  module Rbac
    module Backend
      class Engine < ::Rails::Engine
        isolate_namespace Cmor::Rbac::Backend
      end
    end
  end
end
