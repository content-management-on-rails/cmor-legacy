# frozen_string_literal: true

module Cmor::Seo
  class Item < ApplicationRecord
    include ActsAsPublished::ActiveRecord

    # class OrValidator < ActiveModel::EachValidator
    #   def validate_each(record, attribute, value)
    #     values = options[:others].map{ |o| record.send(o) } + [value]
    #     attribute_names = [attribute] + options[:others]

    #     if options[:exclusive]
    #       if values.count { |x| x.present? } != 1
    #         record.errors.add(attribute, options[:message] || :or)
    #         # record.errors[attribute] << (options[:message] || "exactly one of #{attribute_names.to_sentence} may be present.")
    #       end
    #     else
    #       if values.all? { |x| x.blank? }
    #         record.errors.add(attribute, options[:message] || :or)
    #         # record.errors[attribute] << (options[:message] || "at least one of #{attribute_names.to_sentence} must be present.")
    #       end
    #     end
    #   end
    # end

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
