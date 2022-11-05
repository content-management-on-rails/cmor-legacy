module Cmor
  module Cms
    module DatabaseResolver
      # Include hook for class methods
      def self.included(base)
        base.extend(ClassMethods)
      end

      # class methods go here
      module ClassMethods
      end

      # instance methods go here
      def find_templates(name, prefix, partial, details, locals = [])
        return [] unless resolve(partial)

        conditions = {
          pathname: assert_slashs(prefix.to_s),
          basename: normalize_basename(name),
          locale: normalize_array(details[:locale]).first,
          format: normalize_array(details[:formats]).first,
          handler: normalize_array(details[:handlers])
        }

        format = conditions.delete(:format)
        locale = conditions.delete(:locale)

        query  = template_class.constantize.where(conditions)

        # 1) Only include published templates
        query = query.published

        # 2) Check for templates with the given format or format is nil
        query = query.where(["format = ? OR format = '' OR format IS NULL", format])

        # 3) Ensure templates with format come first
        query = query.order('format DESC')

        # 4) Check for templates with the given locale or locale is nil
        query = query.where(["locale = ? OR locale = '' OR locale IS NULL", locale])

        # 5) Ensure templates with locale come first
        query = query.order('locale DESC')

        # 6) Now trigger the query passing on conditions to initialization
        query.map do |record|
          initialize_template(record, details, locals)
        end
      end

      # Initialize an ActionView::Template object based on the record found.
      def initialize_template(record, details, locals = [])
        source       = build_source(record)
        identifier   = "#{record.class} - #{record.id} - #{record.pathname}#{record.basename}"
        handler      = ::ActionView::Template.registered_template_handler(record.handler)
        virtual_path = "#{record.pathname}#{record.basename}"
        layout = record.layout if record.respond_to?(:layout) && record.layout.present?

        # 5) Check for the record.format, if none is given, try the template
        # handler format and fallback to the one given on conditions
        format   = record.format && Mime[record.format]
        format ||= handler.default_format if handler.respond_to?(:default_format)
        format ||= details[:formats]

        # Rails 6 passes an array of formats instead of a symbol
        format = format.is_a?(Array) ? format.first : format.symbol

        ::ActionView::Template.new(source, identifier, handler, format: format, virtual_path: virtual_path, layout: layout, locals: locals)
      end

      def assert_slashs(prefix)
        output = prefix.dup
        output << '/' unless output.end_with?('/')
        output = '/' << output unless output.start_with?('/')
        output
      end

      # Normalize arrays by converting all symbols to strings.
      def normalize_array(array)
        array.map(&:to_s)
      end

      def build_source
        fail 'call to abstract method #build_source'
      end

      def normalize_basename(_basename)
        fail 'call to abstract method #normalize_basename'
      end

      def resolve(_partial_flag)
        fail 'call to abstract method #resolve'
      end

      def template_class
        fail 'call to abstract method #template_class'
      end
    end
  end
end
