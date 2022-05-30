module Cmor::Core::Api
  class RegisteredEnginesController < ApplicationController
    def index
      render json: Configuration.registered_engines.as_json(
        methods: [
          :identifier,
          :plural_resources,
          :engine_class,
          :singular_name,
          :plural_name
        ]
      )
    end
  end
end
