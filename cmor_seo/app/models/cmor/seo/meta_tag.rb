# frozen_string_literal: true

module Cmor::Seo
  class MetaTag < ApplicationRecord
    include ActsAsPublished::ActiveRecord

    belongs_to :item

    acts_as_list scope: :item
    acts_as_published

    def to_html
      "<meta name=\"#{name}\" content=\"#{content}\" />"
    end

    def human
      "#{item.human}: #{name}"
    end
  end
end
