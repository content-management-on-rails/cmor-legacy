module Cmor
  module Testimonials
    class Category < ActiveRecord::Base
      has_many :testimonials, -> { order(position: :asc) }, dependent: :destroy

      validates :identifier, presence: true, uniqueness: true

      def human
        "#{identifier}"
      end
    end
  end
end
