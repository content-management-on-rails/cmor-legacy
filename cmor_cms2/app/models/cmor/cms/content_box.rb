module Cmor::Cms
  class ContentBox < ActiveRecord::Base
    # associations
    has_many :cmor_cms_page_content_blocks, class_name: 'Page::ContentBlock',
                                           foreign_key: 'cmor_cms_content_box_id'

    # validations
    validates :name, presence: true,
                     uniqueness: true

    delegate :count, to: :cmor_cms_page_content_blocks, prefix: true
  end
end
