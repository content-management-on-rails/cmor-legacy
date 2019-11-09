# frozen_string_literal: true

module Cmor
  module Seo
    module Models
      module SeoableConcern
        extend ActiveSupport::Concern

        included do
          has_one :seo_item, class_name: "Cmor::Seo::Item", as: :resource, dependent: :destroy

          after_save :generate_seo_meta_tags
        end

        def generate_seo_meta_tags
          Cmor::Seo::GenerateMetaTagsService.call_later!(resources: [self])
        rescue => e
          ::Cmor::Seo::Configuration.handle_seoable_after_save_exception.call(e)
        end
      end
    end
  end
end
