module Cmor::Showcase
  class FileDetail < ApplicationRecord
    belongs_to :item
    belongs_to :asset, class_name: 'ActiveStorage::Attachment', dependent: :destroy

    acts_as_list scope: :item
    default_scope { order(position: :asc) }
  end
end
