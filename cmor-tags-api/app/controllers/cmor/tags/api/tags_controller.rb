module Cmor::Tags::Api
  class TagsController < Cmor::Tags::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Tags::Tag
    end

    def self.serializer_class
      Cmor::Tags::Api::TagSerializer
    end
  end
end
