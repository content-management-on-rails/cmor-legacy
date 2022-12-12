module Cmor::Showcase
  class FileDetail < ApplicationRecord
    belongs_to :item, inverse_of: :file_details

    has_one_attached :asset

    acts_as_list scope: :item
    default_scope { order(position: :asc) }

    scope :images,     -> { joins(asset_attachment: [:blob]).where("active_storage_blobs.content_type LIKE '%image/%'") }
    scope :non_images, -> { joins(asset_attachment: [:blob]).where("active_storage_blobs.content_type NOT LIKE '%image/%'") }
  end
end
