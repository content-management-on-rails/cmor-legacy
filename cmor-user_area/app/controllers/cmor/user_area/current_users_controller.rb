module Cmor::UserArea
  class CurrentUsersController < Cmor::Core::Backend::ResourceController::Base
    def self.resource_class
      Cmor::UserArea::User
    end

    def self.available_rest_actions
      %w[show]
    end

    def show
      @resource = current_user
      respond_with @resource
    end

    private

    def permitted_params
      params.require(:user).permit
    end
  end
end
