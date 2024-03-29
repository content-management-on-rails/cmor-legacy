module Cmor
  module Galleries
    class PictureDetail < ApplicationRecord
      include ActsAsPublished::ActiveRecord

      belongs_to :picture_gallery, inverse_of: :picture_details
      belongs_to :asset, class_name: 'ActiveStorage::Attachment', dependent: :destroy

      acts_as_list scope: :picture_gallery

      validates :identifier, uniqueness: true, allow_nil: true

      def human
        title || id
      end

      module DisplayCodesConcern
        extend ActiveSupport::Concern

        def display_code_for_erb
          "<%= pictures_helper(self).render(id: #{id}) %>"
        end
      end

      include DisplayCodesConcern
    end
  end
end
