module Cmor
  module Cms
    class PageType < Cmor::Api::ResourceType::Base
      def self.resource_class
        Cmor::Cms::Page
      end

      infer_fields_from_resource_class!
    end
  end
end
