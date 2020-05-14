require 'cmor/cms/action_view/template_patch'
require 'cmor/cms/action_view/template_renderer_patch'

require 'cmor/cms/engine'
require 'cmor/cms/configuration'

require 'cmor/cms/database_template'

require 'cmor/cms/controller_extensions/layout_resolver'
require 'cmor/cms/controller_extensions/page_resolver'
require 'cmor/cms/controller_extensions/partial_resolver'
require 'cmor/cms/controller_extensions/template_resolver'

module Cmor
  module Cms
    extend Configuration

    def self.table_name_prefix
      'cmor_cms_'
    end
  end
end

Cmor.configure { |c| c.register_configuration(:cms, Cmor::Cms) }