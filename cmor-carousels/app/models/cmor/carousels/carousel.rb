module Cmor
  module Carousels
    class Carousel < ApplicationRecord
      scope :for_locale, ->(locale) { where(arel_table[:locale].eq(locale).or(arel_table[:locale].eq(nil))).order(locale: :desc) }

      validates :locale, inclusion: I18n.available_locales.map(&:to_s),
        if: proc { |carousel| carousel.locale.present? }
      validates :identifier, presence: true,
        uniqueness: {scope: [:locale]}

      def human
        "#{identifier} (#{locale})"
      end

      module ItemDetailsConcern
        extend ActiveSupport::Concern

        included do
          has_many :item_details, inverse_of: :carousel, dependent: :destroy, autosave: true
        end

        def item_details_count
          item_details.count
        end

        def append_item_detail_assets=(collection)
          clean_collection = collection.keep_if { |r| r.present? }
          if clean_collection.any?
            item_details << clean_collection.keep_if { |r| r.present? }.map { |r| item_details.build.tap { |fd| fd.asset.attach(r) } }
          end
        end

        def append_item_detail_assets
          item_details
        end

        def overwrite_item_detail_assets=(collection)
          clean_collection = collection.keep_if { |r| r.present? }
          if clean_collection.any?
            item_details.replace(clean_collection.map { |r| item_details.build.tap { |id| id.asset.attach(r) } })
          end
        end

        def overwrite_item_detail_assets
          item_details
        end
      end

      include ItemDetailsConcern

      module VariantOptionsConcern
        extend ActiveSupport::Concern

        included do
          attr_writer :height, :width

          serialize :variant_options

          validates :width, numericality: true, allow_nil: true, allow_blank: true
          validates :height, numericality: true, allow_nil: true, allow_blank: true

          before_validation :set_variant_options
        end

        def width
          return @width if @width.present?
          return variant_options[:resize].split("x")[0] if variant_options.try(:[], :resize).present?
        end

        def height
          return @height if @height.present?
          return variant_options[:resize].split("x")[1] if variant_options.try(:[], :resize).present?
        end

        private

        def set_variant_options
          self.variant_options = build_variant_options
        end

        def build_variant_options
          {resize: "#{width}x#{height}"}
        end
      end

      include VariantOptionsConcern
    end
  end
end
