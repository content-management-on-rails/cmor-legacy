module Cmor
  module Cms
    module ControllerExtensions
      module LayoutResolver
        def self.included(base)
          # add the template resolver
          base.prepend_view_path ::Cmor::Cms::LayoutResolver.instance unless base.view_paths.include?(::Cmor::Cms::LayoutResolver.instance)
        end
      end
    end
  end
end
