module Cmor
  module Legal
    class AllowedCookie
      extend ActiveModel::Model
      extend ActiveModel::Translation

      def self.attribute_names
        %w(name domain expiry description url)
      end

      attr_accessor *self.attribute_names

      def initialize(attributes = {})
        attributes.each do |key, value|
          send("#{key}=", value)
        end
      end

      def expiry(options = {})
        return if @expiry.nil?

        if options.has_key?(:locale)
          @expiry.is_a?(Symbol) ? I18n.t("activemodel.values.#{self.class.name.underscore}.expiry.#{@expiry}") : localize(options[:locale], @expiry)
        else
          @expiry
        end
      end

      def description(locale: I18n.locale)
        return unless @description.respond_to?(:[]) && @description.has_key?(locale.to_sym)
        @description[locale.to_sym]
      end

      module L10nConcern
        extend ActiveSupport::Concern

        def localize(locale, object, format = :default, options = {})
          if object.is_a?(ActiveSupport::Duration)
            object.parts.collect { |k, v| I18n.t("datetime.distance_in_words.x_#{k}", count: v) }.to_sentence
          else
            I18n.localize(object, locale: locale, format: format, **options)
          end
        end
      end

      include L10nConcern
    end
  end
end
