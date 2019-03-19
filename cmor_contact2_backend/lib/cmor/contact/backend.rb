require "cmor/contact/backend/configuration"
require "cmor/contact/backend/engine"

module Cmor
  module Contact
    module Backend
      extend Configuration
    end
  end
end

Cmor.configure { |c| c.register_configuration(:contact_backend, Cmor::Contact::Backend) }