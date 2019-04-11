module Cmor
  module Core
    module Frontend
      module Configuration
        def configure
          yield self
        end
      end
    end
  end
end
