module Cmor::Cms
  class Page < ActiveRecord::Base
    # add shared behaviour for database backed templates
    include DatabaseTemplate

    # associations
    has_many :navigation_items,
             dependent: :nullify
    has_many :content_blocks,
             dependent: :destroy,
             inverse_of: :page

    accepts_nested_attributes_for :content_blocks, allow_destroy: true

    # callbacks
    after_save :touch_navigation_items

    # validations
    validates :title, presence: true

    def home_page?
      pathname == '/' && basename == 'home'
    end

    def touch_navigation_items
      navigation_items.map(&:update_url_form_page!)
    end
  end
end
