module Cmor
  module Tags
    module Api
      class TagCloudServiceSerializer
        def initialize(result, params = {})
          @result = result
          @params = params
        end

        def as_json
          @result.as_json(except: ['service', 'errors', 'messages'])
        end
      end
    end
  end
end
