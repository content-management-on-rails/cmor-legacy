module Cmor
  module Blog
    module Backend
      module Types
        class PostType < Cmor::Api::Types::Resource::Base
          def self.resource_class
            Cmor::Blog::Post
          end

          infer_fields_from_resource_class!
        end
      end
    end
  end
end
