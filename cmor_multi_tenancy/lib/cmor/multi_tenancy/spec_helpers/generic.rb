module Cmor
  module MultiTenancy
    module SpecHelpers
      module Generic
        def with_client(client)
          Cmor::MultiTenancy.with_client(client) { yield }
        end
      end
    end
  end
end
