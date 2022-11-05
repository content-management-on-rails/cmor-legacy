module Cmor
  module Carousels
    class Carousel < ActiveRecord::Base
      has_many_attached :assets

      scope :for_locale, ->(locale) { where(self.arel_table[:locale].eq(locale).or(self.arel_table[:locale].eq(nil))).order(locale: :desc) }

      validates :locale, inclusion: I18n.available_locales.map(&:to_s),
                        if: proc { |carousel| carousel.locale.present? }
      validates :identifier, presence: true,
                            uniqueness: { scope: [:locale] }

      def human
        "#{identifier} (#{locale})"
      end

      def item_details_count
        item_details.count
      end

      module ItemDetails
        extend ActiveSupport::Concern

        included do
          has_many :item_details, -> { order(position: :asc) }, inverse_of: :carousel, dependent: :destroy, autosave: true
          before_validation :cleanup_orphaned_item_details
          before_validation :ensure_item_details
        end

        def append_assets
          assets
        end

        def append_assets=(assets)
          self.assets.attach(assets)
        end

        def overwrite_assets
          assets
        end

        def overwrite_assets=(assets)
          return if assets.nil? || assets.empty?
          self.item_details.map { |id| id.mark_for_destruction }
          self.assets = assets
        end

        def item_details_count
          item_details.count
        end

        private

        def cleanup_orphaned_item_details
          item_details.each do |item_detail|
            item_detail.destroy if item_detail.asset.nil?
          end
        end

        def ensure_item_details
          (assets - item_details.all.map(&:asset)).map do |asset|
            build_item_detail_for_asset(asset)
          end
        end

        def build_item_detail_for_asset(asset)
          item_details.build(asset: asset, published: true)
        end
      end

      include ItemDetails

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
          { resize: "#{width}x#{height}" }
        end
      end

      include VariantOptionsConcern
    end
  end
end
