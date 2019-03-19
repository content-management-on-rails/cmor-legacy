module Cmor
  module Blog
    module Backend
      class Engine < ::Rails::Engine
        isolate_namespace Cmor::Blog::Backend
      end
    
    end
  end
end



