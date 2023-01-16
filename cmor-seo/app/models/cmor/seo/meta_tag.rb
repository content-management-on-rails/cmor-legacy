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

    module ItemUserstampsConcern
      extend ActiveSupport::Concern

      included do
        attr_accessor :creator, :updater
        after_create :set_creator_on_item!, if: -> { item.present? && creator.present? }
        after_update :set_updater_on_item!, if: -> { item.present? && updater.present? }
        after_destroy :set_updater_on_item!, if: -> { item.present? && updater.present? }
      end

      private

      def set_creator_on_item!
        item.update!(creator: creator)
      end

      def set_updater_on_item!
        item.update!(updater: updater)
      end
    end

    include ItemUserstampsConcern
  end
end
