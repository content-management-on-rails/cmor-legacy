module Cmor::Files
  class FileDetail < ApplicationRecord
    belongs_to :folder
    belongs_to :asset, class_name: 'ActiveStorage::Attachment', dependent: :destroy

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
  end
end
