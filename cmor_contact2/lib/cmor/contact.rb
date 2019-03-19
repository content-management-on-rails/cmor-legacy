require "cmor/contact/configuration"
require "cmor/contact/engine"

module Cmor
  module Contact
    extend Configuration
  end
end

Cmor.configure { |c| c.register_configuration(:contact, Cmor::Contact) }