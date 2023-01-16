module Cmor
  module Cms
    module Models
      module DatabaseTemplateConcern
        extend ActiveSupport::Concern

        included do
          # callbacks
          after_initialize :set_defaults
          before_validation :assert_trailing_slash_on_pathname
          after_save :clear_resolver_cache

          # validations
          validates :basename, presence: true,
            uniqueness: {scope: [:pathname, :locale, :format, :handler]}
          validates :handler, inclusion: {in: ActionView::Template::Handlers.extensions.map(&:to_s)}
          validates :locale, inclusion: {in: I18n.available_locales.map(&:to_s)},
            allow_nil: true,
            allow_blank: true
          validates :format, inclusion: {in: Mime::SET.symbols.map(&:to_s)},
            allow_nil: true,
            allow_blank: true
          validates :pathname, presence: true
        end

        def human
          "#{self.class.name}: #{path_and_filename}"
        end

        def filename
          filename = basename.nil? ? "" : basename.dup
          filename << ".#{locale}" if locale.present?
          filename << ".#{format}" if format.present?
          filename << ".#{handler}" if handler.present?
          filename
        end

        def path_and_filename
          "#{pathname}#{filename}"
        end

        private

        def assert_trailing_slash_on_pathname
          self.pathname = "/" and return if pathname.blank?
          pathname << "/" unless pathname.end_with?("/")
        end

        def clear_resolver_cache
          klass = "#{self.class.name}Resolver"
          klass.constantize.instance.clear_cache
        end

        def set_defaults
          if new_record?
            self.locale ||= I18n.default_locale.to_s
            self.handler ||= Cmor::Cms::Configuration.default_handlers[self.class.name.demodulize.underscore.to_sym].to_s
          end
        end
      end
    end
  end
end
