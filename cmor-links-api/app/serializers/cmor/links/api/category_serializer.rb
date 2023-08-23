module Cmor::Links::Api
  class CategorySerializer
    def initialize(resource, params = {})
      @resource = resource
      @params = params
    end

    def as_json
      @resource.as_json.merge(associations)
    end

    def associations
      return {} unless @params[:populate]
      @params[:populate].each_with_object({}) do |association_name, memo|
        memo[association_name] = @resource.send(association_name)
      end
    end
  end
end
