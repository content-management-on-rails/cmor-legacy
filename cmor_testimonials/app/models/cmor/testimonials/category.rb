module Cmor
  module Testimonials
    class Category < ApplicationRecord
      has_many :testimonials, -> { order(position: :asc) }, dependent: :destroy

      validates :identifier, presence: true, uniqueness: true
    end
  end
end
