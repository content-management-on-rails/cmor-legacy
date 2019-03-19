module Cmor::UserArea::Backend
  class CreateDefaultUserServiceController < Cmor::Core::Backend::ServiceController::Base
    def self.service_class
       Cmor::UserArea::CreateDefaultUserService
    end

    private

    def permitted_params
      params.fetch(:create_default_user_service, {})
    end
  end
end