module Cmor
  module Testimonials
    class Category < ActiveRecord::Base
      has_many :testimonials, -> { order(position: :asc) }, dependent: :destroy do
        def published
          merge(Testimonial.published)
        end
      end

      scope :with, ->(type) { joins(type) }
      scope :with_published_testimonials, -> { with(:testimonials).merge(Testimonial.published) }

      validates :locale, presence: true, inclusion: {in: I18n.available_locales.map(&:to_s)}
      validates :identifier, presence: true, uniqueness: {scope: [:locale]}
      validates :name, presence: true, uniqueness: {scope: [:locale]}

      def human
        name
      end
    end
  end
end
