module Cmor
  module Cms
    module Backend
      module Mutations
        # mutation {
        #   createPage(input: {title: "Test", body: "<h1>Test</h1>", format: "html", handler: "erb", pathname: "/", basename: "test2", metaDescription: "Test"}) {
        #     page {
        #       id
        #     }
        #     errors {
        #       message
        #       path
        #     }
        #   }
        # }
        class CreatePage < Cmor::Api::Mutations::Resource::Create::Base
          def self.resource_class
            Cmor::Cms::Page
          end

          def self.resource_field_type
            Cmor::Cms::Backend::Types::PageType
          end

          initialize!

          argument :title, String, required: true
          argument :meta_description, String, required: true
          argument :body, String, required: true
          argument :pathname, String, required: true
          argument :basename, String, required: true
          argument :format, String, required: true
          argument :handler, String, required: true         
        end
      end
    end
  end
end
