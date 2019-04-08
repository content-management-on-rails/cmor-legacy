require 'cmor/links/configuration'
require 'cmor/links/engine'
require 'cmor/links/routes'

module Cmor
  module Links
    extend Configuration

    def self.table_name_prefix
      'cmor_links_'
    end
  end
end

Cmor.configure { |c| c.register_configuration(:links, Cmor::Links) }