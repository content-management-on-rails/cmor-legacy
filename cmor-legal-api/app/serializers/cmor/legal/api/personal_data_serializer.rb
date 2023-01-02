module Cmor::Legal::Api
  class PeronsalDataSerializer
    def initialize(resource)
      @resource = resource
    end

    def as_json
      @resource.as_json
    end
  end
end
