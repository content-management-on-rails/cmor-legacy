module Cmor
  module Transports
    module Packs
      class Base < Rao::Service::Base
        class Result < Rao::Service::Result::Base
        end

        attr_accessor :outgoing

        private

        def _perform
          pack_and_attach!
        end
      end
    end
  end
end