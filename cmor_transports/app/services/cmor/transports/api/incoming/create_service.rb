# frozen_string_literal: true

module Cmor
  module Transports
    module Api
      module Incoming
        class CreateService < Rao::Service::Base
          class Result < Rao::Service::Result::Base
          end

          attr_accessor :outgoing, :incoming

          validates :outgoing_output_base64, presence: true


          def save
            if @incoming.save
              say "Saved incoming with id #{@incoming.id}"
            else
              add_error_and_say "Could not save incoming. Errors: #{@incoming.errors.full_messages.to_sentence}"
            end
          end

          def outgoing_output_base64
            outgoing["output_base64"] if outgoing.respond_to?(:[])
          end

          private
          def _perform
            build_incoming!
          end

          def build_incoming!
            @incoming = Cmor::Transports::Incoming.new.tap do |i|
              i.outgoing_uuid = outgoing["uuid"]
              i.payload.attach(io: StringIO.new(Base64.decode64(outgoing["output_base64"])), filename: "payload.zip", content_type: "application/zip")
              i.input.attach(io: StringIO.new(outgoing.to_json), filename: "outgoing.json", content_type: "application/json")
              i
            end
          end
        end
      end
    end
  end
end
