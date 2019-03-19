require 'cmor/cms/backend/configuration'
require 'cmor/cms/backend/engine'

module Cmor
  module Cms
    module Backend
      extend Configuration
    end
  end
end

Cmor.configure { |c| c.register_configuration(:cms_backend, Cmor::Cms::Backend) }