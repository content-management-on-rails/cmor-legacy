module Cmor::Restaurant
  class Allergen < ApplicationRecord
    include ::Cmor::Restaurant::ResourceConcern
  end
end
