module Cmor::Restaurant
  class Food < ApplicationRecord
    include ::Cmor::Restaurant::ResourceConcern

    belongs_to :category, inverse_of: :foods

    acts_as_list scope: :category

    monetize :price_cents

    validates :quantity, numericality: {greater_than: 0}
  end
end
