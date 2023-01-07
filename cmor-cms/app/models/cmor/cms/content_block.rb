module Cmor::Cms
  class ContentBlock < ActiveRecord::Base
    # associations
    belongs_to :content_box
    belongs_to :page

    # validations
    validates :body, presence: true

    def content_box_name
      content_box.name
    end
  end
end
