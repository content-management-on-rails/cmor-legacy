# frozen_string_literal: true

module Cmor
  module Transports
    module Transfers
      module Api
        class IncomingStateService < Rao::Service::Base
          class Result < Rao::Service::Result::Base
            attr_accessor :incoming
          end

          attr_accessor :system_identifier, :endpoint, :api_key, :outgoing_uuid

          private
          def target_url
            [endpoint.chomp("/"), "incoming", "show_services.json"].join("/")
          end

          def _perform
            fetch_import_status!
          end

          def fetch_import_status!
            headers = { "Content-Type" => "application/json", authorization: "Bearer #{api_key}" }
            params = { show_service: { outgoing_uuid: outgoing_uuid } }
            response = HTTParty.post(target_url, headers: headers, body: params.to_json)
            parsed_response_body = JSON.parse(response.body)
            if response.created?
              say "success fetching incoming for outgoing with uuid #{outgoing_uuid} on system #{system_identifier}. Incoming: #{parsed_response_body.inspect}"
              @result.incoming = @incoming = parsed_response_body["incoming"]
            else
              add_error_and_say(:base, "http error #{response.code} fetching import status for outgoing with uuid #{outgoing_uuid} on system #{system_identifier}: #{parsed_response_body["message"]}")
            end
          end
        end
      end
    end
  end
end
