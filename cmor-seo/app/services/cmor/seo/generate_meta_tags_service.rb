# frozen_string_literal: true

module Cmor
  module Seo
    class GenerateMetaTagsService < Rao::Service::Base
      class Result < Rao::Service::Result::Base
        attr_accessor :resources, :meta_tags, :items
      end

      attr_accessor :resources, :meta_tags, :items, :default_url_options

      # delegate :url_helpers, to: 'Rails.application.routes'
      # alias_method :main_app, :url_helpers

      module RoutingConcern
        extend ActiveSupport::Concern

        class LocalRouter
          attr_accessor :default_url_options

          def initialize(default_url_options: nil)
            @default_url_options = default_url_options || default_url_options_defaults
          end

          private

          def default_url_options_defaults
            (Rails.application.config.action_controller.default_url_options || Rails.application.config.action_mailer.default_url_options || {host: "localhost", port: "3000"})
          end
        end

        included do
          Rails.application.routes.named_routes.send(:routes).each do |mountpoint, route|
            next unless route.app.app.respond_to?(:ancestors)
            next unless route.app.app.ancestors.include?(Rails::Engine)
            define_method(mountpoint) do
              router_klass = Class.new(LocalRouter)
              router_klass.send(:include, route.app.app.routes.url_helpers)
              router_klass.new(default_url_options: default_url_options)
            end
          end
        end

        def main_app
          router_klass = Class.new(LocalRouter)
          router_klass.send(:include, Rails.application.routes.url_helpers)
          router_klass.new(default_url_options: default_url_options)
        end

        def method_missing(method_name, *args, &block)
          return main_app.send(method_name, *args, &block) if main_app.respond_to?(method_name)
          super
        end

        def respond_to_missing?(method_name, include_private = false)
          main_app.respond_to?(method_name, include_private) || super
        end
      end

      private

      def _perform
        initialize_routing!

        @meta_tags = []
        @result.items = @items = generate_meta_tags_and_titles!
        @meta_tags.flatten!
        @result.meta_tags = @meta_tags
      end

      def initialize_routing!
        # This is bad, but is has to be for the routing to work lazily.
        self.class.include(RoutingConcern) unless self.class < RoutingConcern
      end

      def generate_meta_tags_and_titles!
        say "Generating meta tags for #{resources.count} resources" do
          resources.collect do |resource|
            find_or_initialize_item_for(resource).tap do |item|
              if item.creator.present? || item.updater.present?
                say "Skipping manually created/updated resource"
                next
              end
              @meta_tags << build_or_update_meta_tags_for(item, resource)
              update_title(item, resource)
            end
          end
        end
      end

      def save
        ActiveRecord::Base.transaction do
          @items.map(&:save!)
          @meta_tags.map(&:save!)
        end
      end

      def build_or_update_meta_tags_for(item, resource)
        say "Building/Updating meta tags for #<#{resource.class} id:#{resource.id}>" do
          meta_tag_configuration_for(resource).call.collect do |name, options_proc|
            options = instance_exec(resource, &options_proc)
            initialize_or_update_meta_tag(item, name, options)
          end
        end
      end

      def update_title(item, resource)
        say "Setting title on #<#{resource.class} id:#{resource.id}>" do
          title_proc = title_configuration_for(resource)
          if title_proc.respond_to?(:call)
            item.title = instance_exec(resource, &title_proc)
          end
        end
      end

      def find_or_initialize_item_for(resource)
        (resource.seo_item || resource.build_seo_item).tap do |item|
          item.published = true if item.new_record?
        end
      end

      def meta_tag_configuration_for(resource)
        ::Cmor::Seo::Configuration.resources[resource.class.name][:meta_tags]
      end

      def title_configuration_for(resource)
        ::Cmor::Seo::Configuration.resources[resource.class.name][:title]
      end

      def initialize_or_update_meta_tag(item, name, options)
        ::Cmor::Seo::MetaTag.where(item_id: item.id, name: name).first_or_initialize.tap do |mt|
          say "Processing #{mt.new_record? ? "new" : "existing"} #<MetaTag name: #{name}>" do
            mt.item = item
            mt.content = options.delete(:content)
            mt.published = true if mt.new_record?
          end
        end
      end
    end
  end
end
