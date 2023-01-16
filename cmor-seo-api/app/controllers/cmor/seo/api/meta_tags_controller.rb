module Cmor::Seo::Api
  class MetaTagsController < Cmor::Seo::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Seo::MetaTag
    end

    def self.serializer_class
      Cmor::Seo::Api::MetaTagSerializer
    end
  end
end
