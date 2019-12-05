module Cmor
  module Blog
    module Types
      class PostType < Cmor::Api::Types::BaseObject
        def self.resource_class
          Cmor::Blog::Post
        end

        infer_fields_from_resource_class!
      end
    end
  end
end
