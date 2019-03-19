module Cmor
  module Cms
    module ControllerExtensions
      module PartialResolver
        def self.included(base)
          # add the partial resolver
          base.prepend_view_path ::Cmor::Cms::PartialResolver.instance unless base.view_paths.include?(::Cmor::Cms::PartialResolver.instance)
        end
      end
    end
  end
end
