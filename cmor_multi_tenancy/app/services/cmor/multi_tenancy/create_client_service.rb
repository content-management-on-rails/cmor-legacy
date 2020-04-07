module Cmor
  module MultiTenancy
    class CreateClientService < Rao::Service::Base
      class Result < Rao::Service::Result::Base
        attr_accessor :client, :identifier, :title, :description, :active_form, :active_to, :default
      end

      attr_accessor :identifier, :title, :description, :active_form, :active_to, :default

      def _perform
        @result.client = create_client
      end

      private

      def create_client
        client = ::Client.new(client_attributes)
        say "Creating client [#{client.identifier}]" do
          if client.save
            say '=> [OK]'
          else
            add_error_and_say(:base, "=> [FAILED] Errors: #{client.errors.full_messages.to_sentence}")
          end
          client
        end
      end

      def client_attributes
        client_attribute_defaults.merge(client_attribute_overrides)
      end

      def client_attribute_overrides
        { identifier: identifier, title: title, description: description, active_form: active_form, active_to: active_to, default: default }.compact
      end

      def client_attribute_defaults
        {
          identifier: "www",
          title: "Default",
          description: "This is the default client.",
          active_from: Time.at(0),
          active_to: Time.parse("9999-12-31 23:59:59"),
          default: true,
        }
      end
    end
  end
end