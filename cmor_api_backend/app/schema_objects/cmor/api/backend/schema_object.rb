module Cmor
  module Api
    module Backend
      class SchemaObject < Cmor::Api::SchemaObjects::Resources::Base
        def self.resource_class
          Cmor::Blog::Post
        end

        initialize!
      end
    end
  end
end
