require 'csv'

module Cmor
  module Blog
    # Example:
    #
    # You selected joomla posts from your database like this:
    #
    #    SELECT joomla_content.title, joomla_content.fulltext, joomla_content.created, joomla_content.modified, joomla_users.email
    #    FROM joomla_content, joomla_users
    #    where created_by = joomla_users.id;
    #
    # And exported the data into a csv file like this:
    # 
    #     # tmp/old_posts.csv
    #     title;fulltext;created;modified;email
    #     "My first Post";"This is the body";"2013-02-12 14:22:23";"2013-02-12 21:58:54";john.doe@example.com
    #
    # You can import this csv file from the rails console:
    #
    #     # rails console
    #     Cmor::Blog::ImportPostsService.call({ filename: 'tmp/old_posts.csv', column_map: :joomla, body_source_format: :html }, autosave: true)
    #
    class ImportPostsService < ApplicationService
      class Result < ApplicationService::Result
        attr_accessor :filename, :column_map, :body_source_format, :csv_data, :posts
      end

      COLUMN_MAPS = {
        joomla: {
          title:         :title,
          body:          :fulltext,
          created_at:    :created,
          updated_at:    :modified,
          # published_at:  ->(row) { Time.zone.now },
          published_at:  :created,
          creator_email: :email
        }
      }

      def self.column_maps
        COLUMN_MAPS
      end

      BODY_SOURCE_FORMATS = [:markdown, :html]

      def self.body_source_formats
        BODY_SOURCE_FORMATS
      end

      attr_accessor :filename, :column_map, :body_source_format

      validates :filename, presence: true
      validates :column_map, presence: true, inclusion: column_maps.keys
      validates :body_source_format, presence: true, inclusion: body_source_formats

      private

      def after_initialize
        @creators = {}
        @body_source_format ||= :markdown
      end

      def _perform
        @csv_data = load_csv_data!
        @posts    = build_posts!
        
        ActiveRecord::Base.transaction { @posts.map(&:save!) } if autosave?

        @result.csv_data           = @csv_data
        @result.posts              = @posts
        @result.filename           = @filename
        @result.column_map         = @column_map
        @result.body_source_format = @body_source_format
      end

      def load_csv_data!
        CSV.read(@filename, csv_options)
      end

      def csv_options
        { col_sep: ';', headers: true }
      end

      def build_posts!
        say "Building posts" do
          @csv_data.each_with_index.collect do |row, index|
            build_post(row, index)
          end
        end
      end

      def build_post(row, index)
        say "Building post [#{index}]" do
          attrs = build_post_attributes(row.to_h)
          Cmor::Blog::Post.new(attrs)
        end
      end

      def build_post_attributes(row)
        attrs = column_mapping.each_with_object({}) do |(post_attribute_name, value_key_or_proc), result|
          result[post_attribute_name] = case value_key_or_proc
          when Symbol, String
            row[value_key_or_proc.to_s]
          when Proc
            value_key_or_proc.call(row)
          else
            nil
          end
        end
        attrs[:creator] = load_creator(attrs.delete(:creator_email))
        attrs[:body] = transform_body(attrs.delete(:body) || '') unless @body_source_format == :markdown
        attrs
      end

      def column_maps
        self.class.column_maps
      end

      def column_mapping
        column_maps[@column_map]
      end

      def post_attribute_for_imported_key(key)
        column_mapping.invert[key.to_sym]
      end

      def load_creator(email)
        creator = Cmor::Blog::Configuration.creator_class_name.constantize.where(email: email).first_or_initialize { |u| u.password = u.password_confirmation = SecureRandom.uuid }
        if creator.persisted?
          @creators[email] ||= creator
        else
          creator
        end
      end

      def transform_body(body)
        case @body_source_format
        when :html
          HTMLPage.new(contents: body).markdown
        else
          body
        end
      end
    end
  end
end
