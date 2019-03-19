module Cmor
  module Carousels
    class ItemDetail < ApplicationRecord
      include ActsAsPublished::ActiveRecord

      belongs_to :carousel
      belongs_to :asset, class_name: 'ActiveStorage::Attachment', dependent: :destroy      

      acts_as_list scope: :carousel

      def human
        "#{carousel.class.model_name.human} #{carousel.human} - #{self.class.model_name.human} #{id}"
      end
    end
  end
end
