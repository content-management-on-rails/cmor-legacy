module Cmor::Files
  class FileDetail < ApplicationRecord
    belongs_to :folder, inverse_of: :file_details
    # belongs_to :asset, class_name: 'ActiveStorage::Attachment', dependent: :destroy
    has_one_attached :asset

    # acts as published
    include ActsAsPublished::ActiveRecord
    acts_as_published

    # acts as list
    acts_as_list scope: :folder
    default_scope { order(folder_id: :desc, position: :asc) }

    # slugs
    extend FriendlyId
    friendly_id :title, use: :slugged

    validates :identifier, uniqueness: { scope: [ :folder_id ] }, allow_blank: true, allow_nil: true

    def label
      title.presence || asset&.blob&.filename&.to_s&.truncate(64).presence
    end
  end
end
