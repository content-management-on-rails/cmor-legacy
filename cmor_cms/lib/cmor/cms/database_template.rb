module Cmor
  module Cms
    module DatabaseTemplate
      def self.included(base)
        base.extend(ClassMethods)

        # associations
        base.belongs_to :cmor_cms_folder,
                        class_name: 'Cmor::Cms::Folder',
                        foreign_key: 'cmor_cms_folder_id',
                        optional: true

        # callbacks
        base.after_initialize :set_defaults
        base.before_validation :assert_trailing_slash_on_pathname
        base.after_save :clear_resolver_cache

        # validations
        base.validates :basename, presence: true,
                                  uniqueness: { scope: [:pathname, :locale, :format, :handler] }
        base.validates :handler, inclusion: ActionView::Template::Handlers.extensions.map(&:to_s)
        base.validates :locale, inclusion: I18n.available_locales.map(&:to_s),
                                allow_nil: true,
                                allow_blank: true
        base.validates :format, inclusion: Mime::SET.symbols.map(&:to_s),
                                allow_nil: true,
                                allow_blank: true
        base.validates :pathname, presence: true
      end

      module ClassMethods
      end

      def human
        "#{self.class.name}: #{path_and_filename}"
      end

      def filename
        filename = basename.nil? ? '' : basename.dup
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
        self.pathname = '/' and return if pathname.blank?
        pathname << '/' unless pathname.end_with?('/')
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
