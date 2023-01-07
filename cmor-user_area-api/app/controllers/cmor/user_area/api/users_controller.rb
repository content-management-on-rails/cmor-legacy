module Cmor::UserArea::Api
  class UsersController < Cmor::UserArea::Api::ResourcesController::Base
    def self.resource_class
      Cmor::UserArea::User
    end

    def self.serializer_class
      Cmor::UserArea::Api::UserSerializer
    end
  end
end
