# frozen_string_literal: true

module Cmor::Seo
  class Item < ApplicationRecord
    include ActsAsPublished::ActiveRecord

    belongs_to :creator, class_name: Cmor::Seo::Configuration.creator_class_name, foreign_key: 'created_by_id', optional: true
    belongs_to :updater, class_name: Cmor::Seo::Configuration.creator_class_name, foreign_key: 'updated_by_id', optional: true
    belongs_to :resource, polymorphic: true, optional: true
    has_many :meta_tags, -> { order(position: :asc) }, inverse_of: :item
    accepts_nested_attributes_for :meta_tags, reject_if: :all_blank, allow_destroy: true

    acts_as_published

    validates :resource, or: { others: [ :path ], exclusive: true }

    def human
      if resource.present?
        "#{resource.class.name}: #{resource_label}"
      else
        path
      end
    end

    def title_tag
      return unless title.present?
      "<title>#{title}</title>"
    end

    def meta_tags_count
      meta_tags.count
    end

    def meta_tags_to_html
      meta_tags.map(&:to_html).join("\n")
    end

    private
      def resource_label
        resource.try(:human).presence || resource.try(:email).presence || resource.try(:name) || resource.try(:identifier).presence || resource.to_s
      end
  end
end
