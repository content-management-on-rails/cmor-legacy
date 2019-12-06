module Cmor
  module Blog
    module Backend
      class PostSchemaObject < Cmor::Api::SchemaObjects::Resources::Base
        def self.resource_class
          Cmor::Blog::Post
        end

        initialize!
      end
    end
  end
end
