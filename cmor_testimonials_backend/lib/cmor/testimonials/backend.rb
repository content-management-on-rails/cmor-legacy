require 'cmor/testimonials/backend/configuration'
require 'cmor/testimonials/backend/engine'
module Cmor
  module Testimonials
    module Backend
      # Your code goes here...
      extend Configuration
    end
  end
end

Cmor.configure { |c| c.register_configuration(:testimonials_backend, Cmor::Testimonials::Backend) }