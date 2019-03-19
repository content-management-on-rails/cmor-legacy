module Cmor::Files
  class FileDetail < ApplicationRecord
    belongs_to :folder
    belongs_to :asset, class_name: 'ActiveStorage::Attachment', dependent: :destroy
  end
end
