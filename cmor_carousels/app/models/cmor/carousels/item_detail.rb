module Cmor
  module Carousels
    class ItemDetail < ApplicationRecord
      include ActsAsPublished::ActiveRecord
      include Markup::Rails::ActiveRecord

      belongs_to :carousel, inverse_of: :item_details

      has_one_attached :asset

      acts_as_list scope: :carousel
      acts_as_markup :description, Cmor::Core::Configuration.default_markup_options

      validates :asset, attached: true

      def human
        "#{carousel.class.model_name.human} #{carousel.human} - #{self.class.model_name.human} #{id}"
      end

      module ContentTypesConcern
        extend ActiveSupport::Concern

        def video?
          asset.content_type.start_with?('video/')
        end

        def image?
          asset.content_type.start_with?('image/')
        end
      end

      include ContentTypesConcern
    end
  end
end
