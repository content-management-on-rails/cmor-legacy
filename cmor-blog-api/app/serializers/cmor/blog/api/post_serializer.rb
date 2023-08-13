module Cmor::Blog::Api
  class PostSerializer
    def initialize(resource, params = {})
      @resource = resource
      @params = params
    end

    def as_json
      @resource.as_json(except: [:tag_list], include: (@params[:populate] || []))
    end
  end
end
