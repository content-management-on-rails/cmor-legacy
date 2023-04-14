module Cmor::UserArea
  class CreateDefaultUserServiceController < Cmor::Core::Backend::ServiceController::Base
    def self.service_class
      Cmor::UserArea::CreateDefaultUserService
    end

    private

    def initialize_service_for_create
      @service ||= service_class.new(permitted_params.delete_if { |k, v| v.blank? })
    end

    def permitted_params
      params.require(:create_default_user_service).permit(:email, :password, :password_confirmation, :active, :approved, :confirmed)
    end
  end
end
