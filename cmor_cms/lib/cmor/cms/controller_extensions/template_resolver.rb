module Cmor
  module Cms
    module ControllerExtensions
      module TemplateResolver
        def self.included(base)
          # add the template resolver
          base.prepend_view_path ::Cmor::Cms::TemplateResolver.instance unless base.view_paths.include?(::Cmor::Cms::TemplateResolver.instance)
        end
      end
    end
  end
end
