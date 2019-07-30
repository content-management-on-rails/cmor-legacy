module Cmor::Showcase
  class Item < ApplicationRecord
    include ActsAsPublished::ActiveRecord
    include Markup::Rails::ActiveRecord

    belongs_to :category

    has_many_attached :assets
    
    acts_as_list scope: :category
    acts_as_published
    acts_as_markup :body, Cmor::Core::Configuration.default_markup_options

    validates :name, presence: true, uniqueness: { scope: [ :category_id ] }

    module PreviewPictureConcern
      extend ActiveSupport::Concern

      def images
        assets.joins(:blob).where("active_storage_blobs.content_type LIKE '%image/%'")
      end

      def non_images
        assets.joins(:blob).where("active_storage_blobs.content_type NOT LIKE '%image/%'")
      end

      def preview_picture
        images.first
      end
    end

    include PreviewPictureConcern
  end
end
