module Cmor::Addresses
  class AddressesController < Cmor::Core::Backend::ResourcesController::Base
    def self.resource_class
      Cmor::Addresses::Address
    end

    private

    def permitted_params
      params.require(:address).permit()
    end
  end
end