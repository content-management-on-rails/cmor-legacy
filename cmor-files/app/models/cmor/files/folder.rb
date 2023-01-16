module Cmor
  module Files
    class Folder < ApplicationRecord
      include Cmor::Core::Model::LocalizationConcern

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

      module FileDetailsConcern
        extend ActiveSupport::Concern

        included do
          has_many :file_details, inverse_of: :folder, dependent: :destroy, autosave: true
        end

        def file_details_count
          file_details.count
        end

        def append_file_detail_assets=(collection)
          clean_collection = collection.keep_if { |r| r.present? }
          if clean_collection.any?
            file_details << clean_collection.map { |r| file_details.build.tap{ |fd| fd.asset.attach(r) } }
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
