require 'cmor/blog/configuration'
require 'cmor/blog/engine'


module Cmor
  module Blog
    extend Configuration
  end
end

Cmor.configure { |c| c.register_configuration(:blog, Cmor::Blog) }
