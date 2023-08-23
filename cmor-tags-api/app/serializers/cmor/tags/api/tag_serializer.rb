module Cmor::Tags::Api
  class TagSerializer
    def initialize(resource, params = {})
      @resource = resource
      @params = params
    end

    def as_json
      @resource.as_json
    end
  end
end
