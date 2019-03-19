require 'cmor/carousels/engine'
require 'cmor/carousels/configuration'

module Cmor
  module Carousels
    extend Configuration

    def self.table_name_prefix
      'cmor_carousels_'
    end
  end
end

Cmor.configure { |c| c.register_configuration(:carousels, Cmor::Carousels) }