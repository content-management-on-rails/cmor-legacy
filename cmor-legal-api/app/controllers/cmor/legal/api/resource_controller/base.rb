module Cmor::Legal::Api
  module ResourceController
    class Base < Cmor::Legal::Api::ApplicationController
      include Rao::Api::ResourceController::RestActionsConcern
      include Rao::Api::ResourceController::ResourceConcern
      include Cmor::Core::Api::ResourceController::SerializationConcern
    end
  end
end
