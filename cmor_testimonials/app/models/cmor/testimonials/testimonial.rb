module Cmor
  module Testimonials
    class Testimonial < ApplicationRecord
      include ActsAsPublished::ActiveRecord
      include Markup::Rails::ActiveRecord

      has_one_attached :image
      belongs_to :category

      acts_as_list scope: :category
      acts_as_published
      acts_as_markup :description, format: Cmor::Core::Configuration.default_markup_language

      def human
        "#{fullname} (#{role}) - #{company}"
      end
    end
  end
end
