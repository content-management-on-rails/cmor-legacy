module Cmor
  module Blog
    class PostType < Cmor::Api::ResourceType::Base
      def self.resource_class
        Cmor::Blog::Post
      end

      infer_fields_from_resource_class!
    end
  end
end
