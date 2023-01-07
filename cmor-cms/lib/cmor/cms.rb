require "acts_as_list"
require "acts_as_published"
require "awesome_nested_set"
require "cmor_core_backend"
require "rao-service"
require "RedCloth"

require "cmor/cms/version"
require "cmor/cms/configuration"
require "cmor/cms/engine"

require "cmor/cms/action_view/template_patch"
require "cmor/cms/action_view/template_renderer_patch"

module Cmor
  module Cms
    def self.configure
      yield Configuration
    end
  end
end
