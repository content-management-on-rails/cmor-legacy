module Cmor::Restaurant
  class Additive < ApplicationRecord
    include ::Cmor::Restaurant::ResourceConcern
  end
end
