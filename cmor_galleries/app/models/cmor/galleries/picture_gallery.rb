module Cmor
  module Galleries
    class PictureGallery < ApplicationRecord
      include Cmor::Core::Model::CollectionConcern

      module PictureDetailsConcern
        extend ActiveSupport::Concern

        included do
          has_many :picture_details, inverse_of: :picture_gallery, dependent: :destroy, autosave: true
        end

        def picture_details_count
          picture_details.count
        end

        def append_picture_detail_assets=(collection)
          collection.map { |r| self.picture_details.build.tap { |fd| fd.asset.attach(r); fd } }
        end

        def append_picture_detail_assets
          picture_details
        end

        def overwrite_picture_detail_assets=(collection)
          picture_details.replace(collection.map { |r| picture_details.build.tap { |fd| fd.asset.attach(r); fd } })
        end

        def overwrite_picture_detail_assets
          picture_details
        end
      end

      include PictureDetailsConcern

      def human
        name
      end

      def assets_count
        assets.count
      end

      module DisplayCodesConcern
        extend ActiveSupport::Concern

        def display_code_for_erb
          "<%= galleries_helper(self).render(name: '#{name}') %>"
        end
      end

      include DisplayCodesConcern
    end
  end
end
