module Cmor
  module Core
    module Model
      module LocalizationConcern
        extend ActiveSupport::Concern

        included do
          validates :locale, inclusion: { in: I18n.available_locales.map(&:to_s) }, allow_nil: true, allow_blank: true

          scope :for_locale, ->(locale = I18n.locale, options = {}) do
            options.reverse_merge!(include_without_locale: true)

            if options[:include_without_locale]
              where(locale: locale).or(where(locale: nil))
            else
              where(locale: locale)
            end
          end
        end
      end
    end
  end
end
