module Cmor::Contact::Api
  module ResourceController
    class Base < Cmor::Contact::Api::ApplicationController
      include Rao::Api::ResourceController::RestActionsConcern
      include Rao::Api::ResourceController::ResourceConcern
      include Rao::Api::ResourceController::SerializationConcern
      include Rao::Api::ResourceController::ExceptionHandlingConcern
      include Cmor::Core::Api::ResourceController::SerializationConcern
    end
  end
end
