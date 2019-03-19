module Cmor
  module Tags
    module Backend
      class Engine < ::Rails::Engine
        isolate_namespace Cmor::Tags::Backend
      end
    end
  end
end
