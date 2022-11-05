module Cmor
  module Files
    class Folder < ApplicationRecord
      include Cmor::Core::Model::LocalizationConcern

      has_many_attached :assets

      # acts as published
      include ActsAsPublished::ActiveRecord
      acts_as_published

      # acts as list
      acts_as_list
      default_scope { order(position: :asc) }

      # slugs
      extend FriendlyId
      friendly_id :name, use: :slugged


      validates :name, presence: true, uniqueness: { scope: [ :locale ] }
      validates :identifier, uniqueness: { scope: [ :locale ] }, allow_nil: true, allow_blank: true

      def human
        "#{self.class.model_name.human}: #{self.name}"
      end

      def assets_count
        assets.count
      end

      def file_details_count
        file_details.count
      end

      module FileDetailsConcern
        extend ActiveSupport::Concern

        included do
          has_many :file_details, inverse_of: :folder, dependent: :destroy, autosave: true
          before_validation :cleanup_orphaned_file_details
          before_validation :ensure_file_details
        end

        def append_assets
          assets
        end

        def append_assets=(assets)
          self.assets.attach(assets)
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
end
