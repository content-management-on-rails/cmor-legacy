module Cmor
  module Galleries
    class PictureGallery < ApplicationRecord
      include Cmor::Core::Model::CollectionConcern

      module PictureDetailsConcern
        extend ActiveSupport::Concern

        included do
          has_many :picture_details, inverse_of: :picture_gallery, dependent: :destroy
        end

        def picture_details_count
          picture_details.count
        end

        def append_picture_detail_assets=(collection)
          clean_collection = collection.keep_if { |r| r.present? }
          if clean_collection.any?
            picture_details << clean_collection.map { |r| picture_details.build.tap{ |pd| pd.asset.attach(r) } }
          end
        end

        def append_picture_detail_assets
          picture_details
        end

        def overwrite_picture_detail_assets=(collection)
          clean_collection = collection.keep_if { |r| r.present? }
          if clean_collection.any?
            picture_details.replace(clean_collection.map { |r| picture_details.build.tap { |pd| pd.asset.attach(r) } })
          end
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
