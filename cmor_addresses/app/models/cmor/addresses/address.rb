module Cmor::Addresses
  class Address < ApplicationRecord
    belongs_to :role
  end
end
