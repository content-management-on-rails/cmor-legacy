module Cmor::Seo::Api
  class MetaTagSerializer
    def initialize(resource)
      @resource = resource
    end

    def as_json
      @resource.as_json
    end
  end
end
