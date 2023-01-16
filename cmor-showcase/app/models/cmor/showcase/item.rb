module Cmor
  module Showcase
    class Item < ApplicationRecord
      include ActsAsPublished::ActiveRecord
      include Markup::Rails::ActiveRecord

      belongs_to :category

      acts_as_list scope: :category
      default_scope -> { order(:category_id, :position) }
      acts_as_published

      # slugs
      extend FriendlyId
      friendly_id :name, use: :slugged

      acts_as_markup :body, Cmor::Core::Configuration.default_markup_options

      validates :name, presence: true, uniqueness: {scope: [:category_id]}

      module PreviewPictureConcern
        extend ActiveSupport::Concern

        def preview_picture
          file_details.images.first
        end
      end

      include PreviewPictureConcern

      module FileDetailsConcern
        extend ActiveSupport::Concern

        included do
          has_many :file_details, inverse_of: :item, dependent: :destroy, autosave: true
        end

        def file_details_count
          file_details.count
        end

        def append_file_detail_assets=(collection)
          clean_collection = collection.keep_if { |r| r.present? }
          if clean_collection.any?
            file_details << clean_collection.map { |r| file_details.build.tap { |fd| fd.asset.attach(r) } }
          end
        end

        def append_file_detail_assets
          file_details
        end

        def overwrite_file_detail_assets=(collection)
          clean_collection = collection.keep_if { |r| r.present? }
          if clean_collection.any?
            file_details.replace(clean_collection.map { |r| file_details.build.tap { |fd| fd.asset.attach(r) } })
          end
        end

        def overwrite_file_detail_assets
          file_details
        end
      end

      include FileDetailsConcern
    end
  end
end
