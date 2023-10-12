module Cmor
  module MultiTenancy
    class SeedService < Rao::Service::Base
      class Result < Rao::Service::Result::Base
        attr_accessor :client
      end

      def _perform
        @result.client = create_client
      end

      private

      def create_client
        r = Cmor::MultiTenancy::CreateClientService.call
        if r.success?
          r.client
        else
          add_error_and_say(:client_service, r.errors.full_messages.to_sentence)
          nil
        end
      end
    end
  end
end
