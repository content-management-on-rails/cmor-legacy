module Cmor::Cms
  class ContentBox < ActiveRecord::Base
    # associations
    has_many :content_blocks

    # validations
    validates :name, presence: true,
                     uniqueness: true

    delegate :count, to: :content_blocks, prefix: true
  end
end
