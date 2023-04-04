module Cmor::Restaurant
  class Additive < ApplicationRecord
    include ::Cmor::Restaurant::ResourceConcern

    has_many :food_additives, inverse_of: :additive, dependent: :destroy
    has_many :foods, through: :food_additives
  end
end
