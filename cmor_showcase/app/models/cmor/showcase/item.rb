module Cmor::Showcase
  class Item < ApplicationRecord
    include ActsAsPublished::ActiveRecord
    include Markup::Rails::ActiveRecord

    belongs_to :category

    has_many_attached :assets
    
    acts_as_list scope: :category
    default_scope -> { order(:category_id, :position) }
    acts_as_published

    # slugs
    extend FriendlyId
    friendly_id :name, use: :slugged

    acts_as_markup :body, Cmor::Core::Configuration.default_markup_options

    validates :name, presence: true, uniqueness: { scope: [ :category_id ] }

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
        has_many :file_details, inverse_of: :item, dependent: :destroy, autosave: true do
          def images
            joins(asset: :blob).where("active_storage_blobs.content_type LIKE '%image/%'")
          end

          def non_images
            joins(asset: :blob).where("active_storage_blobs.content_type NOT LIKE '%image/%'")
          end
        end
        before_validation :cleanup_orphaned_file_details
        before_validation :ensure_file_details
      end

      def append_assets
        assets
      end

       def append_assets=(assets)
          if Rails.version < '6.0.0'
            self.assets = assets
          else
            self.assets.attach(assets)
          end
        end

      def overwrite_assets
        assets
      end

      def overwrite_assets=(assets)
        return if assets.nil? || assets.empty?
        self.file_details.map { |fd| fd.mark_for_destruction }
        self.assets = assets
      end

      private

      def cleanup_orphaned_file_details
        file_details.each do |file_detail|
          file_detail.destroy if file_detail.asset.nil?
        end
      end

      def ensure_file_details
        (assets - file_details.all.map(&:asset)).map do |asset|
          build_file_detail_for_asset(asset)
        end
      end

      def build_file_detail_for_asset(asset)
        file_details.build(asset: asset)
      end
    end

    include FileDetailsConcern
  end
end
