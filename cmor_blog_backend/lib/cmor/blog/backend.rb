require 'cmor_blog'
require 'cmor-core-backend'
require 'rao-query'

require 'cmor/blog/backend/configuration'
require "cmor/blog/backend/engine"

module Cmor
  module Blog
    module Backend
      extend Configuration
    end
  end
end

Cmor.configure { |c| c.register_configuration(:blog_backend, Cmor::Blog::Backend) }