module Cmor::Blog
  class AssetDetail < ApplicationRecord
    belongs_to :post, inverse_of: :asset_details
    has_one_attached :asset
    validates :asset, attached: true

    acts_as_list scope: :post_id

    # acts as published
    include ActsAsPublished::ActiveRecord
    acts_as_published

    scope :images,     -> { joins(asset_attachment: [:blob]).where("active_storage_blobs.content_type LIKE '%image/%'") }
    scope :non_images, -> { joins(asset_attachment: [:blob]).where("active_storage_blobs.content_type NOT LIKE '%image/%'") }

    def filename
      asset&.blob&.filename
    end

    def human
      filename
    end
  end
end
