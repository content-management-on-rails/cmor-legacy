module Cmor::Legal::Api
  class PrivacyPolicySerializer
    def initialize(resource)
      @resource = resource
    end

    def as_json
      @resource.as_json
    end
  end
end
