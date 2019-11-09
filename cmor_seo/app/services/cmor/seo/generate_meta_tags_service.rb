# frozen_string_literal: true

module Cmor
  module Seo
    class GenerateMetaTagsService < Rao::Service::Base
      class Result < Rao::Service::Result::Base
        attr_accessor :resources, :meta_tags
      end

      attr_accessor :resources, :meta_tags

      # delegate :url_helpers, to: 'Rails.application.routes'
      # alias_method :main_app, :url_helpers

      module RoutingConcern
        extend ActiveSupport::Concern

        class LocalRouter
          attr_accessor :default_url_options

          def initialize(default_url_options: nil)
            @default_url_options = default_url_options
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

        def method_missing(m, *args, &block)
          return main_app.send(m, *args, &block) if main_app.respond_to?(m)
          super
        end

        def default_url_options
          @default_url_options ||= (Rails.application.config.action_controller.default_url_options || Rails.application.config.action_mailer.default_url_options || { host: "http://localhost:3000" })
        end
      end

      include RoutingConcern

      private
        def _perform
          @meta_tags = generate_meta_tags!

          @result.meta_tags = @meta_tags
        end

        def generate_meta_tags!
          say "Generating meta tags for #{resources.count} resources" do
            resources.collect do |resource|
              build_or_update_meta_tags_for(resource)
            end.flatten
          end
        end

        def save
          ActiveRecord::Base.transaction do
            @meta_tags.map(&:save!)
          end
        end

        def build_or_update_meta_tags_for(resource)
          say "Building/Updating meta tags for #<#{resource.class} id:#{resource.id}>" do
            item = find_or_initialize_item_for(resource)
            meta_tag_configuration_for(resource).call.collect do |name, options_proc|
              options = instance_exec(resource, &options_proc)
              initialize_or_update_meta_tag(item, name, options)
            end
          end
        end

        def find_or_initialize_item_for(resource)
          (resource.seo_item || resource.build_seo_item).tap do |item|
            item.published = true if item.new_record?
            item
          end
        end

        def meta_tag_configuration_for(resource)
          ::Cmor::Seo::Configuration.resources[resource.class.name][:meta_tags]
        end

        def initialize_or_update_meta_tag(item, name, options)
          ::Cmor::Seo::MetaTag.where(item_id: item.id, name: name).first_or_initialize.tap do |mt|
            say "Processing #{mt.new_record? ? 'new' : 'existing'} #<MetaTag name: #{name}>" do
              mt.item = item
              mt.content = options.delete(:content)
              mt.published = true if mt.new_record?
            end
          end
        end
    end
  end
end
