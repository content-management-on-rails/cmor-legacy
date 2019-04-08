require "cmor/contact/configuration"
require "cmor/contact/engine"
require "cmor/contact/routes"

module Cmor
  module Contact
    extend Configuration
  end
end

Cmor.configure { |c| c.register_configuration(:contact, Cmor::Contact) }