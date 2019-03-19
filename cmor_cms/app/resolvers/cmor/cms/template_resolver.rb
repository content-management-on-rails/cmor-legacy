require 'cmor/cms/database_resolver'

module Cmor
  module Cms
    class TemplateResolver < ::ActionView::Resolver
      require 'singleton'
      include Singleton

      # add shared behaviour for database backed templates
      include Cmor::Cms::DatabaseResolver

      def build_source(record)
        record.body
      end

      def normalize_basename(basename)
        basename
      end

      def resolve(partial_flag)
        !partial_flag
      end

      def template_class
        'Cmor::Cms::Template'
      end
    end
  end
end
