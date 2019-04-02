module Cmor
  module Testimonials
    class Testimonial < ApplicationRecord
      include ActsAsPublished::ActiveRecord

      has_one_attached :image
      belongs_to :category

      acts_as_list scope: :category
      acts_as_published
    end
  end
end
