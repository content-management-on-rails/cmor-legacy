module Cmor::Addresses
  class AddressesController < Cmor::Core::Backend::ResourcesController::Base
    def self.resource_class
      Cmor::Addresses::Address
    end

    private

    def permitted_params
      params.require(:address).permit(:role_id, :line1, :line2, :line3, :street, :housenumber, :zipcode, :city, :country, :addressable_type, :addressable_id)
    end
  end
end