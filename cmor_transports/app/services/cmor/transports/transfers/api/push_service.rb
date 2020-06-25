module Cmor
  module Transports
    module Transfers
      module Api
        class PushService < Rao::Service::Base
          class Result < Rao::Service::Result::Base
          end

          attr_accessor :outgoing

          private
            
          def target_url(endpoint)
            [endpoint.chomp("/"), "incoming", "create_services.json"].join("/")
          end


          def _perform
            push_to_all_systems!
          end

          def push_to_all_systems!
            outgoing.reload.start_transferring!
            outgoing.systems.each do |system|
              push_to_system(system)
            end
            outgoing.succeed_transferring! if outgoing.may_succeed_transferring?
          end

          def push_to_system(system)
            headers = { "Content-Type" => "application/json", authorization: "Bearer #{system.api_key}" }
            params = { create_service: { outgoing: outgoing.as_json(methods: :output_base64) } }
            response = HTTParty.post(target_url(system.endpoint), headers: headers, body: params.to_json)
            if response.created?
              say "success pushing outgoing #{outgoing.uuid} to system #{system.identifier}"
            else
              parsed_response_body = JSON.parse(response.body)
              add_error_and_say(:base, "http error #{response.code} transferring outgoing #{outgoing.uuid} to system #{system.identifier}: #{parsed_response_body["message"]}")
              outgoing.failed_transferring!
            end
          end
        end
      end
    end
  end
end
