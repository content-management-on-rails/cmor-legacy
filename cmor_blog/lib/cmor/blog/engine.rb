module Cmor
  module Blog
    class Engine < ::Rails::Engine
      isolate_namespace Cmor::Blog
    end
  end
end
