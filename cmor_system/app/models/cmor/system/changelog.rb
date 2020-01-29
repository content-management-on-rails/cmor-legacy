module Cmor
  module System
    class Changelog
      if Object.const_defined?('Kaminari')
        class Collection < Kaminari::PaginatableArray
        end
      else
        class Collection < Array
        end
      end

      extend ActiveModel::Model
      extend ActiveModel::Naming
      include ActiveModel::Conversion
      extend ActiveModel::Translation
      include ActiveModel::Validations
      include Markup::Rails::ActiveRecord

      validates :name, presence: true
      validates :file, presence: true

      def self.attribute_names
        %w(id name gem file content version)
      end

      module AttributesConcern
        extend ActiveSupport::Concern

        included do
          attr_accessor :attributes

          delegate :[], to: :attributes

          attribute_names.each do |attr|
            define_method(attr) do
              @attributes[attr.to_sym]
            end

            define_method("#{attr}=") do |value|
              @attributes[attr.to_sym]= value
            end
          end
        end

        class_methods do
        end

        def initialize(attributes = {})
          @attributes = {}.with_indifferent_access
          attributes.each do |k, v|
            self.send("#{k}=", v)
          end
        end
      end

      include AttributesConcern

      module ActiveRecordLikeConcern
        extend ActiveSupport::Concern

        class_methods do
          def reorder(order)
            key = order.first[0].to_sym
            value = order.first[1].to_sym
            sorted = _all.sort { |a, b| a.send(key) <=> b.send(key) }
            value == :asc ? sorted : sorted.reverse
            Collection.new(value == 'asc' ? sorted : sorted.reverse)
          end

          def count
            all.size
          end

          def first
            all.first
          end

          def _all
            application_changelog = Rails.root.join("CHANGELOG.md")
            app_changelog = if File.exist?(application_changelog)
              version = if Rails.application.class.parent.const_defined?("VERSION")
                Rails.application.class.parent::VERSION
              end
              new(id: Rails.application.class.name.deconstantize.underscore, name: Rails.application.class.name.deconstantize.underscore, gem: nil, file: application_changelog, version: version)
            end

            gem_changelogs = Gem::Specification.all.sort.collect do |gem|
              gem_root = gem.gem_dir
              changelog = File.join(gem_root, "CHANGELOG.md")
              if File.exist?(changelog)
                new(id: gem.name, name: gem.name, gem: gem, file: changelog, version: gem.version.to_s)
              end
            end

            [app_changelog, gem_changelogs].flatten.compact
          end

          def all
            Collection.new(_all)
          end

          def find(id)
            all.select { |cl| cl.id == id }.first || raise(ActiveRecord::RecordNotFound)
          end
        end

        def to_key
          [id]
        end

        def persisted?
          true
        end

        def read_attribute(name)
          @attributes[name.to_sym]
        end

        def write_attribute(name, value)
          @attributes[name.to_sym] = value
        end

          def ==(other)
            false unless other.respond_to?(:id) && other.respond_to?(:name) && other.respond_to?(:gem) && other.respond_to?(:version)
            self.id == other.id &&
            self.name == other.name &&
            self.gem == other.gem &&
            self.version == other.version
          end
      end

      include ActiveRecordLikeConcern

      module PaginationConcern
        extend ActiveSupport::Concern

        class_methods do
          def page(page)
            all.page(page)
          end
        end
      end

      include PaginationConcern

      acts_as_markup :content, processor: :markdown

      def read_attribute(name)
        if name.to_sym == :content
          if @attributes[:content].nil? && @attributes[:file].present?
            @attributes[:content] = File.read(@attributes[:file])
          else
            @attributes[:content]
          end
        else
          super
        end
      end
    end
  end
end
