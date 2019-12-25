require "cmor/contact/frontend/configuration"
require "cmor/contact/frontend/engine"

module Cmor
  module Contact
    module Frontend
      extend Configuration
    end
  end
end

Cmor.configure { |c| c.register_configuration(:contact_frontend, Cmor::Contact::Frontend) }