module Cmor
  module Cms
    class PageResolver < ::ActionView::Resolver
      require 'singleton'
      include Singleton

      # add shared behaviour for database backed templates
      include Cmor::Cms::DatabaseResolver

      def build_source(record)
        output = ''
        record.content_blocks.each do |content_block|
          # rendered_body = RedCloth.new(begin;content_block.body;end).to_html.html_safe
          rendered_body = RedCloth.new(content_block.body).to_html
          output << "<% content_for :#{content_block.content_box_name} do %>#{rendered_body}<% end %>"
        end
        
        output << content_for_title(record)
        output << content_for_meta_description(record)
        
        output << record.body unless record.body.nil?

        output
      end

      def normalize_basename(basename)
        basename
      end

      def resolve(partial_flag)
        !partial_flag
      end

      def template_class
        'Cmor::Cms::Page'
      end

      private

      def content_for_title(record)
        case record.handler
        when 'haml'
          "= content_for(:title) { \"#{record.title}\" }\r\n"
        else
          "<% content_for :title do %>#{record.title}<% end %>"
        end
      end

      def content_for_meta_description(record)
        case record.handler
        when 'haml'
          "= content_for(:meta_description) { \"#{record.meta_description}\" }\r\n"
        else
          "<% content_for :meta_description do %>#{record.meta_description}<% end %>"
        end
      end
    end
  end
end
