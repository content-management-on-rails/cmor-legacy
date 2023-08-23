module Cmor
  module Tags
    module Api
      class SearchServiceSerializer
        def initialize(result, params = {})
          @result = result
          @params = params
        end

        def as_json
          @result.as_json(except: ['service', 'results', 'errors', 'messages']).merge(
            results: serialized_results
          )
        end

        def serialized_results
          @result.results.each_with_object({}) do |(k,v),m|
            m[k] = {
              resources: v.map { |o| serialize_resource(o) },
              meta: k.constantize.attribute_names.each_with_object({}) { |an, memo| memo[an] = k.constantize.human_attribute_name(an)  }
            }
          end
        end

        def serialize_resource(resource)
          {
            id: resource.id,
            attributes: resource.attributes.except('id'),
          }
        end
      end
    end
  end
end
