module Cmor::Cms
  class Page::ContentBlock < ActiveRecord::Base
    # associations
    belongs_to :cmor_cms_content_box, class_name: 'ContentBox',
                                     foreign_key: 'cmor_cms_content_box_id'
    belongs_to :cmor_cms_page, class_name: 'Cmor::Cms::Page',
                              foreign_key: 'cmor_cms_page_id'

    # attributes
    attr_accessible(:body,
                    :cmor_cms_content_box_id) if Rails.version < '4.0.0'

    # validations
    validates :body, presence: true
    validates :cmor_cms_content_box, presence: true
    validates :cmor_cms_page, presence: true
    # validates :cmor_cms_page, :existence => true

    def content_box_name
      cmor_cms_content_box.name
    end
  end
end
