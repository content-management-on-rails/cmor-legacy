module Cmor
  module Cms
    module ControllerExtensions
      module PageResolver
        def self.included(base)
          # add the page resolver
          base.prepend_view_path ::Cmor::Cms::PageResolver.instance unless base.view_paths.include?(::Cmor::Cms::PageResolver.instance)
        end
      end
    end
  end
end
