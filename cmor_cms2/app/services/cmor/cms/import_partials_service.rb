module Cmor::Cms
  class ImportPartialsService < Rao::Service::Base
    class Result < Rao::Service::Result::Base
    end

    class PartialInFileSystem
      def initialize(filename, view_path)
        @filename = filename
        @view_path = view_path
      end

      def pathname
        @pathname ||= "#{File.dirname(relative_filename)}/"
      end

      def basename
        @basename ||= File.basename(relative_filename).split('.').first
      end

      def locale
        locale = File.basename(relative_filename).split('.')[-3]
        if I18n.available_locales.map(&:to_s).include?(locale)
          @locale ||= locale
        end
      end

      def format
        format = File.basename(relative_filename).split('.')[-2]
        @format ||= format if Mime::SET.symbols.map(&:to_s).include?(format)
      end

      def handler
        handler = File.basename(relative_filename).split('.').last
        if ActionView::Template::Handlers.extensions.map(&:to_s).include?(handler)
          @handler ||= handler
        end
      end

      def body
        File.read(@filename)
      end

      def to_partial_attributes_hash
        {
          pathname: pathname,
          basename: basename,
          locale:   locale,
          format:   format,
          handler:  handler,
          body:     body
        }
      end

      def human
        "#{relative_filename} (#{body.size} bytes)"
      end

      private

      def relative_filename
        @relative_filename ||= @filename.gsub(view_path.to_s, '')
      end

      attr_reader :view_path
    end

    attr_accessor :view_path, :force

    validates :view_path, presence: true

    def initialize(attributes = {}, options = {})
      attributes.reverse_merge!(view_path: Rails.root.join(*%w(app views)), force: false)
      super(attributes, options)
    end

    def _perform    
      @partials = load_partials
      partials_count = @partials.size
      info "Processing #{partials_count} partials in #{view_path}:"
      @partials.each_with_index do |partial, index|
        info "  (#{index + 1}/#{partials_count}) #{partial.human}"
        attributes_hash = partial.to_partial_attributes_hash
        partial = force ? find_or_initialize_partial(attributes_hash) : initialize_partial(attributes_hash)
        new_record = partial.new_record?
        partial.attributes = attributes_hash
        if partial.save
          info "    #{new_record ? 'Created' : 'Updated'} #{partial.human}"
        else
          info "    Could not #{new_record ? 'create' : 'update'} #{partial.human}. Errors: #{partial.errors.full_messages.to_sentence}"
        end
      end
    end

    def force=(value)
      @force = if Rails.version < '5.0'
        ActiveRecord::Type::Boolean.new.type_cast_from_database(value)
      else
        ActiveRecord::Type::Boolean.new.cast(value)
      end
    end

    private

    def find_or_initialize_partial(attributes)
      attributes = attributes.dup
      attributes.compact!.delete(:body)
      Partial.where(attributes).first_or_initialize
    end

    def initialize_partial(attributes)
      Partial.new(attributes)
    end

    def load_partials
      load_partials_absolute.collect { |file| PartialInFileSystem.new(file, view_path) }
    end

    def load_partials_absolute
      Dir.glob("#{view_path}/**/_*.*")
    end
  end
end
