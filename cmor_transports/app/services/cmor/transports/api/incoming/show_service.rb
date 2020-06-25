module Cmor
  module Transports
    module Api
      module Incoming
        class ShowService < Rao::Service::Base
          class Result < Rao::Service::Result::Base
            attr_accessor :incoming
          end

          attr_accessor :outgoing_uuid

          private

          def _perform
            @result.incoming = @incoming = Cmor::Transports::Incoming.where(outgoing_uuid: outgoing_uuid).first
          end
        end
      end
    end
  end
end