module ActiveModel
  module Validations
    class FileReadabilityValidator < ::ActiveModel::EachValidator
      def validate_each(record, attribute, value)
        filename = File.expand_path(value) if !value.nil? && value.respond_to?(:to_s)
        if filename.nil?
          record.errors.add(attribute, options[:message] || :filename_is_nil)
          return
        end
        unless File.exists?(filename)
          record.errors.add(attribute, options[:message] || :file_not_existent, filename: filename)
          return
        end
        unless File.file?(filename)
          record.errors.add(attribute, options[:message] || :file_not_file, filename: filename)
          return
        end
        unless File.readable?(filename)
          record.errors.add(attribute, options[:message] || :file_not_readable, filename: filename)
          return
        end
      end
    end
  end
end