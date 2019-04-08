require 'cmor/blog/feature'
require 'cmor/blog/configuration'
require 'cmor/blog/engine'
require 'cmor/blog/routes'


module Cmor
  module Blog
    extend Configuration
  end
end

Cmor.configure { |c| c.register_configuration(:blog, Cmor::Blog) }
