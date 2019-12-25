require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'

module Cmor
  module Contact
    module Configuration
      def configure
        yield self
      end

      mattr_accessor :registered_controllers do
        lambda do
          []
        end
      end

      mattr_accessor :registered_services do
        lambda do
          []
        end
      end

      mattr_accessor :recipients do
        ->(environment) { "jane.doe@domain.local" }
      end

      mattr_accessor :sender do
        ->(mail_form) { %("#{mail_form.name}" <#{mail_form.email}>) }
      end

      mattr_accessor :contact_request_include_modules do
        ->() { [Cmor::Contact::ContactRequest::PhoneConcern] }
      end

      mattr_accessor :whatsapp_number do
        nil
      end
    end
  end
end
