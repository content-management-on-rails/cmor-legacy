module Cmor::Cms
  class Page < ActiveRecord::Base
    # add shared behaviour for database backed templates
    include DatabaseTemplate

    # associations
    has_many :cmor_cms_navigation_items,
             class_name: 'NavigationItem',
             dependent: :nullify,
             foreign_key: 'cmor_cms_page_id'
    has_many :cmor_cms_page_content_blocks,
             class_name: 'Cmor::Cms::Page::ContentBlock',
             dependent: :destroy,
             foreign_key: 'cmor_cms_page_id',
             inverse_of: :cmor_cms_page

    accepts_nested_attributes_for :cmor_cms_page_content_blocks, allow_destroy: true

    # callbacks
    after_save :touch_navigation_items # , :if => Proc.new { |page| page.locale_changed? || page.pathname_changed? || page.basename_changed? }

    # validations
    validates :title, presence: true

    def home_page?
      pathname == '/' && basename == 'home'
    end

    def touch_navigation_items
      cmor_cms_navigation_items.map(&:update_url_form_page!)
    end
  end
end
