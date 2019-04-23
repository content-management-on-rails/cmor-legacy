require 'cmor/testimonials/engine'
require 'cmor/testimonials/configuration'

module Cmor
  module Testimonials
    extend Configuration

    def self.table_name_prefix
      'cmor_testimonials_'
    end
  end
end

Cmor.configure { |c| c.register_configuration(:testimonials, Cmor::Testimonials) }