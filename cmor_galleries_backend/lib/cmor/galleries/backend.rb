require 'cmor/galleries/backend/configuration'
require "cmor/galleries/backend/engine"

module Cmor
  module Galleries
    module Backend
      extend Configuration
    end
  end
end

Cmor.configure { |c| c.register_configuration(:galleries_backend, Cmor::Galleries::Backend) }